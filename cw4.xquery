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
                <th>Probability</th> 
            </tr>
            {
                (:SearchBy variable to store the word to be searched:)
                let $searchBy := "has"
                (:Get all the words from all the xml files:)
                let $all :=
                    for $x in collection('.?select=*.xml')//s
                    return
                        for $w in $x/w
                        return normalize-space(data($w))
                (:Get all the successor words of the given searchBy word:)
                let $succ := 
                    for $x in collection('.?select=*.xml')//s
                    return
                        for $w in $x/w
                        let $w2 := $w/following-sibling::w[1]
                        where lower-case(normalize-space($w)) = $searchBy
                        return normalize-space(data($w2))
                (:Get the probability of a successor word to come after searchBy word in every xml file:)
                let $results :=
                    for $x in distinct-values($succ)
                    let $frequency := count(index-of($succ,$x))
                    let $total-frequency := count(index-of($all,$x))
                    let $probability := $frequency div $total-frequency
                    (:Order the output by probability and then by the word:)
                    order by xs:float($probability) descending, lower-case($x)
                    return <tr><td>{$searchBy}</td><td>{$x}</td><td>{$probability}</td></tr>
                (:print the first 20 results:)
                for $x in subsequence($results, 1, 20)
                return $x
            }
        </table>
    </body> 
</html>
