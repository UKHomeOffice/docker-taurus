# Docker Gradle

[![Build Status](https://drone.acp.homeoffice.gov.uk/UKHomeOffice/docker-taurus/status.svg)](https://drone.acp.homeoffice.gov.uk/UKHomeOffice/docker-taurus) 

Blazemeter Tuarus in a docker image, the version of the image / tag will match the version of Taurus and SemVer. 

For more information on this please refer to: [Docker Tuarus](https://github.com/Blazemeter/taurus)

## Getting Started

This is to provide the performance testing tool as part of a CI pipeline / local delivery development pipeline
for a service. It's to make sure that CI can operate in a complete containerised world.

Blazemeter test yaml data is mounted into the container under /code where that becomes the WORKDIR and then bzt is run
from that directory on the code

### Environment Variables

* `TAURUS_VERSION` - the version of Taurus BZT to pip install

### Volumes

* `/bzt` - This is where the blazmeter tests are mounted and is also the WORKDIR

### Usage

docker run -v "${PWD}":/bzt quay.io/ukhomeofficedigital/taurus:v0.8.3

## Contributing

Contributions are most certainly welcome. If you want to introduce a breaking
change or any other major change, please raise an issue first to discuss.

## License

[MIT](LICENSE)
