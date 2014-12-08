<html>
    <head>
        <link rel="stylesheet" type="text/css" href="xquery.css"/>
    </head>
    <body> 
        <h1> Results </h1> 
        <table> 
            <tr>
                <th>Target</th>
                <th>Successor</th>
                <th>Frequency</th> 
            </tr>
            {
            (:SearchBy variable to store the word to be searched:)
            let $searchBy := "has"
            (:Store all the successor words of the SearchBy word in Succ variable:)
            let $succ := 
                for $x in collection('.?select=*.xml')//s
                return
                    for $w in $x/w
                    let $w2 := $w/following-sibling::w[1]
                    where lower-case(normalize-space($w)) = $searchBy
                    (:Remove space from the words:)
                    return normalize-space(data($w2))
            (:Search for distinct words in the succ words list:)
            for $x in distinct-values($succ)
            (:get all the positions of the given word in the succ word list
            and store the count in frequency:)
            let $frequency := count(index-of($succ,$x))
            (:order the output by frequency and then by the word:)
            order by xs:integer($frequency) descending, lower-case($x)
            return <tr><td>{$searchBy}</td><td>{$x}</td><td>{$frequency}</td></tr>
            }
        </table>
    </body> 
</html>
