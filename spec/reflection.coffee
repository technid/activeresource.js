describe 'ActiveResource', ->
  describe '::Reflection', ->
    describe '#reflections', ->
      it 'returns a reflections object', ->
        reflections = MyLibrary::Product.reflections()
        expect(_.keys(reflections)[0]).toEqual('orders')
        expect(_.values(reflections)[0].isA?(ActiveResource::Reflection::HasManyReflection)).toBeTruthy()

    describe '#reflectOnAllAssociations', ->
      beforeEach ->
        @reflections = MyLibrary::Order.reflectOnAllAssociations()

      it 'returns a collection', ->
        expect(@reflections.isA?(ActiveResource::Collection)).toBeTruthy()

      it 'returns reflections', ->
        expect(@reflections.first().isA?(ActiveResource::Reflection::AbstractReflection)).toBeTruthy()

      describe 'when a macro is provided', ->
        beforeEach ->
          @reflections = MyLibrary::Order.reflectOnAllAssociations('hasMany')

        it 'scopes to reflections of that macro', ->
          expect(@reflections.size()).toEqual(2)

    describe '#reflectOnAssociation', ->
      it 'gets the specific reflection', ->
        expect(
          MyLibrary::Product
          .reflectOnAssociation('orders')
          .isA?(ActiveResource::Reflection::HasManyReflection)
        ).toBeTruthy()

    describe '#reflectOnAllAutosaveAssociations', ->
      it 'gets all autosave reflections', ->
        expect(
          MyLibrary::Order
          .reflectOnAllAutosaveAssociations()
          .first()
          .options['autosave']
        ).toBeTruthy()

  describe 'building reflections using ::Associations', ->
    describe '.hasMany', ->
      beforeEach ->
        class MyLibrary::Customer extends ActiveResource::Base
          @hasMany 'orders'

      it 'builds a hasMany reflection', ->
        reflection = MyLibrary::Customer.reflectOnAssociation('orders')
        expect(reflection.isA?(ActiveResource::Reflection::HasManyReflection)).toBeTruthy()

      it 'builds an accessor method into the class prototype', ->
        expect(MyLibrary::Customer::['orders']).toBeDefined()

      it 'builds a loader method into the class prototype', ->
        expect(MyLibrary::Customer::['loadOrders']).toBeDefined()

    describe '.hasOne', ->
      beforeEach ->
        class MyLibrary::GiftCard extends ActiveResource::Base
          @hasOne 'order'

      it 'builds a hasOne reflection', ->
        reflection = MyLibrary::GiftCard.reflectOnAssociation('order')
        expect(reflection.isA?(ActiveResource::Reflection::HasOneReflection)).toBeTruthy()

      it 'builds an accessor method into the class prototype', ->
        expect(MyLibrary::GiftCard::['order']).toBeDefined()

      it 'builds a loader method into the class prototype', ->
        expect(MyLibrary::GiftCard::['loadOrder']).toBeDefined()

      it 'builds an assigner method into the class prototype', ->
        expect(MyLibrary::GiftCard::['assignOrder']).toBeDefined()

      it 'builds an updater method into the class prototype', ->
        expect(MyLibrary::GiftCard::['updateOrder']).toBeDefined()

      it 'builds a builder method into the class prototype', ->
        expect(MyLibrary::GiftCard::['buildOrder']).toBeDefined()

      it 'builds a creator method into the class prototype', ->
        expect(MyLibrary::GiftCard::['createOrder']).toBeDefined()

    describe '.belongsTo', ->
      beforeEach ->
        class MyLibrary::AttributeValue extends ActiveResource::Base
          @belongsTo 'order'

      it 'builds a belongsTo reflection', ->
        reflection = MyLibrary::AttributeValue.reflectOnAssociation('order')
        expect(reflection.isA?(ActiveResource::Reflection::BelongsToReflection)).toBeTruthy()

      it 'builds an accessor method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['order']).toBeDefined()

      it 'builds a loader method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['loadOrder']).toBeDefined()

      it 'builds an assigner method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['assignOrder']).toBeDefined()

      it 'builds an updater method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['updateOrder']).toBeDefined()

      it 'builds a builder method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['buildOrder']).toBeDefined()

      it 'builds a creator method into the class prototype', ->
        expect(MyLibrary::AttributeValue::['createOrder']).toBeDefined()