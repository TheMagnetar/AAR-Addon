/*
Changes structures into strings of json

Example formats:

["number", 5] => 5
["string", "hello world"] => "hello world"
["object", ["hello", ["string", "world"]]] => {"hello": "world"}
["object", ["first", ["number", 1]], ["second", ["number", 2]]] => {"first": 1, "second": 2}
["array", ["string", "hello"], ["string", "world"]] => ["hello", "world"]
*/

SerializeJson = {
  params ["_type", "_value"];

  switch _type do
  {
    case "number":
    {
      _value;
    };
    case "string":
    {
      format ["""%1""", _value];
    };
    case "object":
    {
      private "_objects";
      _objects = [];

      {
        params ["_objKey", "_objValue"];

        _objValue = _objValue call SerializeJson;

        _objects pushBack (format ["""%1"":%2", _objKey, _objValue]);
      } forEach (_this select [1, count _this]);

      format ["{%1}", _objects joinString ","];
    };
    case "array":
    {
      private _array = [];

      {
        _array pushBack (_x call SerializeJson);
      } forEach (_this select [1, count _this]);

      format ["[%1]", _array joinString ","];
    };
  }
};

_this call SerializeJson;
