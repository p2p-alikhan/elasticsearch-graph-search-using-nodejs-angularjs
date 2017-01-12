curl -X DELETE '10.0.2.2:9200/books'
curl -XPUT '10.0.2.2:9200/books?pretty' -d'
{
    "mappings": {
        "marketing" : {
            "properties" : {
                "title" : {
                    "type" : "completion"
                },
                "author" : {
                    "type": "keyword"
                }
            }
        }
    }
}'

curl -XPOST '10.0.2.2:9200/books/marketing/_bulk?pretty' -d'
{ "index":{"_id" : "1" }}
{ "author": "David Meerman Scott","title":{ "input": "The New Rules of Marketing & PR" }}
{ "index":{"_id" : "2" }}
{ "author": "Dharmesh Shah","title":{ "input": "Inbound Marketing by Brian Halligan" }}
{ "index":{"_id" : "3" }}
{ "author": "Nir Eyal","title":{ "input": "Hooked: How to Build Habit-Forming Products" }}
{ "index":{"_id" : "4" }}
{ "author": "Dan Ariely","title":{ "input": "Predictably Irrational" }}
{ "index":{"_id" : "5" }}
{ "author": "Scott Belsky","title":{ "input": "Making Ideas Happen" }}
{ "index":{"_id" : "6" }}
{ "author": "Jonah Berger","title":{ "input": "Contagious: Why Things Catch On" }}
{ "index":{"_id" : "7" }}
{ "author": "Dale Carnegie","title":{ "input": "How to Win Friends and Influence People" }}
{ "index":{"_id" : "8" }}
{ "author": "Robert Cialdini","title":{ "input": "Influence: The Psychology of Persuasion" }}
{ "index":{"_id" : "9" }}
{ "author": "Chip & Dan Heath","title":{ "input": "Made to Stick" }}
{ "index":{"_id" : "10" }}
{ "author": "Daniel Kahneman","title":{ "input": "Thinking Fast and Slow" }}
{ "index":{"_id" : "11" }}
{ "author": "Douglas Atkin","title":{ "input": "The Culting of Brands: Turn Your Customers into True Believers" }}
{ "index":{"_id" : "12" }}
{ "author": "Shane Snow","title":{ "input": "Smartcuts: How Hackers, Innovators, and Icons Accelerate Success" }}
{ "index":{"_id" : "13" }}
{ "author": "Charles Mackay","title":{ "input": "Extraordinary Popular Delusions and the Madness of Crowds" }}
{ "index":{"_id" : "14" }}
{ "author": "Daniel Pink","title":{ "input": "To Sell is Human" }}
{ "index":{"_id" : "15" }}
{ "author": "Mark Boulton","title":{ "input": "A Practical Guide to Designing for the Web" }}
{ "index":{"_id" : "16" }}
{ "author": "Guy Kawasaki and Peg Fitzpatrick","title":{ "input": "The Art of Social Media" }}
{ "index":{"_id" : "17" }}
{ "author": "Ryan Holiday","title":{ "input": "Growth Hacker Marketing" }}
{ "index":{"_id" : "18" }}
{ "author": "Eliyahu M. Goldratt","title":{ "input": "The Goal: A Process of Ongoing Improvement" }}
{ "index":{"_id" : "19" }}
{ "author": "Jay Baer","title":{ "input": "Youtility: Why Smart Marketing Is about Help Not Hype" }}
{ "index":{"_id" : "20" }}
{ "author": "Al Ries and Jack Trout","title":{ "input": "The 22 Immutable Laws of Marketing" }}
{ "index":{"_id" : "21" }}
{ "author": "Ann Handley","title":{ "input": "Everybody Writes" }}
{ "index":{"_id" : "22" }}
{ "author": "Joe Pulizzi","title":{ "input": "Epic Content Marketing" }}
{ "index":{"_id" : "23" }}
{ "author": "David Ogilvy","title":{ "input": "Ogilvy on Advertising" }}
{ "index":{"_id" : "24" }}
{ "author": "F.L. Lucas","title":{ "input": "Style: The Art of Writing Well" }}
{ "index":{"_id" : "25" }}
{ "author": "David Allen","title":{ "input": "Getting Things Done" }}
'

<<COMMENT1

curl -XPUT '10.0.2.2:9200/music/song/1?refresh&pretty' -d'
{
    "title": "post1",
	"suggest" : {
        "input": "great pakistan"        
    }
}'

curl -XPUT '10.0.2.2:9200/music/song/2?refresh&pretty' -d'
{
    "title": "post2",
	"suggest" : {
        "input": "pakistan new"        
    }
}'

curl -XPUT '10.0.2.2:9200/music/song/3?refresh&pretty' -d'
{
    "title": "post3",
	"suggest" : {
        "input": "afghanistan"        
    }
}'

curl -XPUT '10.0.2.2:9200/music/song/4?refresh&pretty' -d'
{
    "title": "post4",
	"suggest" : {
        "input": "pakistan is best"        
    }
}'


curl -XPOST '10.0.2.2:9200/music/_search?size=0&pretty' -d'
{
    "_source": "suggest",
    "suggest": {
        "song-suggest" : {
            "prefix" : "pak",
            "completion" : {
                "field" : "suggest"
            }
        }
    }
}'


curl -XPOST '10.0.2.2:9200/music/_suggest?pretty=true' -d'
{
    "song-suggest" : {
        "prefix" : "pak",
        "completion" : {
            "field" : "suggest"
        }
    }
}'
COMMENT1
