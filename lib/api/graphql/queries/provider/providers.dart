class ProvidersQuery {
  String get providers {
    return '''
      query PROVIDERS_QUERY {
        providers{
          id
          email
          fullName
          address {
            address
            latitude
            longitude
          }
          dayTimes {
            day {
              day
            }
            time {
              startTime
              endTime
            }
          }
          bookings {
            rating {
              rate
            }
          }
          serviceProviderCategories {
            category {
              category
            }
            service {
              id
              description
              duration
              durationUnit
              inHouse
              price
              title
            }
          }
          staffs {
            id
            fullName
          }
        }
      }
    ''';
  }
}