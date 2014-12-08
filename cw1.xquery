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
            </tr>
            {
            (:SearchBy variable to store the word to be searched:)
            let $searchBy := "has"
            (:Get all the sentences from all the xml files in the current directory:)
            for $x in collection('.?select=*.xml')//s
            return
                (:Get all the words from the given sentence:)
                for $w in $x/w
                (:Remove space and convert to lower case each word and compare with "has":)
                where lower-case(normalize-space($w)) = $searchBy
                (:Print the word if it is has and also print its successor element:)
                return <tr><td>{data($w)}</td><td>{data($w/following-sibling::w[1])}</td></tr>
            }
        </table>
    </body> 
</html>
