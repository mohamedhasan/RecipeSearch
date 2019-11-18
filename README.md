# RecipeSearch
This project is a solution for the iOS Technical Assignment in Schibsted, it acts as list/details screen app, that search for Recipes

## API
Edamam free Api is used:
https://developer.edamam.com/edamam-docs-recipe-api\

Authentication keys used :\
APP_ID = "81684560"\
APP_KEY = "e83fcffc992684f40663c1ffd2537ffe"

### Edamam Api only allow 100 results per search query, some areas in code are modified to make this exception.
### Edamam Api doesn't include social rank as required in the task, so for now it is left as (Zero)

## External Libraries

### Alarmofire
For the simplicity and speed I chose to use Alarmofire for networking, instead of the normal NSURLConnection, this helped me to focus more on the Logic and UI.
### SDWebImage
For Loading images from web.

## Areas of Improvements
#### Scale up fonts and image for iPad.
#### Cover more test cases in Unit testing.
#### UITesting


## Important Notes
#### Project built with VIP architecture, that I personally liked, as it is very clean, and quick for this type of small applications.
#### Project built to be able to make minimal change in case any need to change Recipes source(API), the concept of protocols are used for this purpose.
#### Unit testing: I added some dependency injection to add the ability to specify which fetching Data(Data provider) I would like to use, in this way mocking data is much easier and used directly by the real used code.
#### Empty Space search query is ignored.
#### iPad has it's own experience, by simply using UISplitViewController.

