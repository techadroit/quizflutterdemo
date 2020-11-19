enum Categories{
  linux,
  devops,
  networking,
  cloud,
  docker,
  kubernates
}

extension CategoryParsing on Categories{
  String value(){
    return this.toString().substring(this.toString().indexOf('.') + 1);
  }
}