# 20BN dataset download tools

To help download the 20BN datasets, you can use these scripts.

You'll have to login in to the 20BN dataset page that you wish to download, and
then open up the dev tools console to run some javascript to collect the
download links (which are specific to you after logging in, and only valid for a
limited amount of time)

# Step 1. Obtaining download urls

Go to one of the 20BN dataset pages and log in so that the download links appear:

* [something-something-v1](https://20bn.com/datasets/something-something/v1)
* [something-something-v2](https://20bn.com/datasets/something-something/v2)
* [jester-v1](https://20bn.com/datasets/jester)

Open up the dev tools console in your brower (Ctrl+Shift+K in firefox) and paste
in the following code:

```js
let download_re = /20bn-(something-something-v(?:1|2)|jester-v1)-(\d\d)(?:\.md5)?/
let download_links = Array.from(document.getElementsByTagName('a'))
  .map((a) => a.href)
  .filter((href) => download_re.test(href) && !/md5/.test(href))
bash_urls="download_links=(\n"
download_links.map((href) => {
  bash_urls += `  "${href}"\n`
})
bash_urls += ")\n"
console.log(bash_urls)
```

It'll print out a bash string that you should then copy and paste into a file,
e.g. `something-something-urls.sh`

# Step 2. Download the dataset

Run 

```bash
$ ./download.sh something-something-urls.sh
``` 

(replace the `something-something-urls.sh` filename with whatever file you created in step 1)

Wait until all the files have been downloaded and extract with:

```
$ cat 20bn-*-v?-?? | tar zx
```
