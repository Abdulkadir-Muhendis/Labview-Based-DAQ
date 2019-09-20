document.write("<table id=\"outlink\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width: 186px; height: 210px; background-color: #F2F2EE; text-align: center;\"><tr><td><h3 id=\"currenciesHeading\" class=\"leftBoxHeading\"><label>Track your package</label></h3></td></tr><tr><td style=\" vertical-align: middle;height:100%;\"><textarea style=\"width: 166px; height: 100px;\" id=\"nums17Track\"></textarea></td></tr><tr><td style=\"height:40px;\"><input type=\"button\" value=\"Search\" onclick=\"search17Track()\" /></td></tr></table>");

function search17Track() {

    function trim(input) {
        var reExtraSpace = /^\s*(.*?)\s+$/;
        return input.replace(reExtraSpace, "$1");
    }

    var input = trim(document.getElementById("nums17Track").value);

    if (input == "")
        return;

    var results = input.split("\n");
    var resultString = "";

    for (var i = 0; i < results.length; i++) {
        var temp = trim(results[i].toString());
        if (temp == "")
            continue;

        resultString = resultString.concat(temp + ",");
    }

    if (resultString.lastIndexOf(",") == resultString.length - 1)
        resultString = resultString.substring(0, resultString.length - 1);

    var url = "http://17track.net/IndexEn.html?nums=" + escape(resultString);

    window.open(url);
}