<html>
    <head>
        <link rel="stylesheet" type="text/css" href="xquery.css"/>
    </head>
    <body> 
        <h1> Results </h1> 
        <table> 
            <tr>
                <th> Target </th>
                <th>Successor</th>
                <th>Probaility</th> 
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
                for $x in distinct-values($succ)
                (:frequency of the word as the successor of the searchBy word:)
                let $frequency := count(index-of($succ,$x))
                (:frequency of the word in all the xml files:)
                let $total-frequency := count(index-of($all,$x))
                (:probability of the word being a successor to searchBy word:)
                let $probability := $frequency div $total-frequency
                order by xs:float($probability) descending, lower-case($x)
                return <tr><td>{$searchBy}</td><td>{$x}</td><td>{$probability}</td></tr>
            }
        </table>
    </body> 
</html>
