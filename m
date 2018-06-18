Return-Path: <n.merinov@inango-systems.com>
X-Greylist: delayed 358 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 18 Jun 2018 06:35:02 UTC
Received: from main-1.inango.com (main-1.inango-systems.com [5.189.174.2])
	by mail.openembedded.org (Postfix) with ESMTP id 74902744DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2018 06:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by main-1.inango.com (Postfix) with ESMTP id 5A3DD45767D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2018 09:29:05 +0300 (IDT)
X-Virus-Scanned: Debian amavisd-new at mail.inango-systems.com
Received: from main-1.inango.com ([127.0.0.1])
	by localhost (main-1.inango.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M1eusZTqeKyr; Mon, 18 Jun 2018 09:29:02 +0300 (IDT)
Received: from [192.168.73.123] (unknown [194.60.247.123])
	by main-1.inango.com (Postfix) with ESMTPSA id C6233455E93;
	Mon, 18 Jun 2018 09:29:01 +0300 (IDT)
To: bitbake-devel@lists.openembedded.org
References: <20180513144849.6526-1-n.merinov@inango-systems.com>
From: Nikolai Merinov <n.merinov@inango-systems.com>
Organization: Inango-SW LTD
Message-ID: <dc319812-8dba-159d-9a51-a97ee607b834@inango-systems.com>
Date: Mon, 18 Jun 2018 11:29:05 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
	Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <20180513144849.6526-1-n.merinov@inango-systems.com>
Subject: Re: [PATCH] fetch2: Use correct check in parameter handling in uri_replace()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 18 Jun 2018 06:35:02 -0000
X-Groupsio-MsgNum: 9351
Content-Type: multipart/alternative;
	boundary="------------20F3260D48578299BD4DD648"
Content-Language: en-US

--------------20F3260D48578299BD4DD648
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Any review on this?

Regards,
Nikolai

On 5/13/18 7:48 PM, Nikolai Merinov wrote:
> If uri_find contain parameters then original URI parameters should
> be checked against parameters from uri_find instead of parameters
> from uri_replace.
> ---
>   lib/bb/fetch2/__init__.py | 4 ++--
>   lib/bb/tests/fetch.py     | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 72d6092d..829f1903 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -452,8 +452,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>               # Handle URL parameters
>               if i:
>                   # Any specified URL parameters must match
> -                for k in uri_replace_decoded[loc]:
> -                    if uri_decoded[loc][k] != uri_replace_decoded[loc][k]:
> +                for k in uri_find_decoded[loc]:
> +                    if uri_decoded[loc][k] != uri_find_decoded[loc][k]:
>                           return None
>               # Overwrite any specified replacement parameters
>               for k in uri_replace_decoded[loc]:
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 74859f9d..66a9ddb5 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -402,6 +402,8 @@ class MirrorUriTest(FetcherTest):
>               : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
>           ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
>               : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
> +        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
> +            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
>   
>           #Renaming files doesn't work
>           #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-- 
<http://inango.com>
Nikolai Merinov
Team Leader, 3rd Party Group
n.merinov@inango-systems.com
T +7 343 298 0147 C +7 912 229 2564
inango.com <http://inango.com>Inango on LinkedIn <https://www.linkedin.com/company/inango>

--------------20F3260D48578299BD4DD648
Content-Type: multipart/related;
 boundary="------------0B1BFA8A7A45AC0C158AFC08"

--------------0B1BFA8A7A45AC0C158AFC08
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello,</p>
    <p>Any review on this?</p>
    <p>Regards,<br>
      Nikolai<br>
    </p>
    <div class="moz-cite-prefix">On 5/13/18 7:48 PM, Nikolai Merinov
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180513144849.6526-1-n.merinov@inango-systems.com">
      <pre class="moz-quote-pre" wrap="">If uri_find contain parameters then original URI parameters should
be checked against parameters from uri_find instead of parameters
from uri_replace.
---
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/tests/fetch.py     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 72d6092d..829f1903 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -452,8 +452,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
             # Handle URL parameters
             if i:
                 # Any specified URL parameters must match
-                for k in uri_replace_decoded[loc]:
-                    if uri_decoded[loc][k] != uri_replace_decoded[loc][k]:
+                for k in uri_find_decoded[loc]:
+                    if uri_decoded[loc][k] != uri_find_decoded[loc][k]:
                         return None
             # Overwrite any specified replacement parameters
             for k in uri_replace_decoded[loc]:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74859f9d..66a9ddb5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -402,6 +402,8 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http") 
             : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
+            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
 
         #Renaming files doesn't work
         #(<a class="moz-txt-link-rfc2396E" href="http://somewhere.org/somedir1/somefile_1.2.3.tar.gz">"http://somewhere.org/somedir1/somefile_1.2.3.tar.gz"</a>, <a class="moz-txt-link-rfc2396E" href="http://somewhere.org/somedir1/somefile_1.2.3.tar.gz">"http://somewhere.org/somedir1/somefile_1.2.3.tar.gz"</a>, <a class="moz-txt-link-rfc2396E" href="http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz">"http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"</a>) : <a class="moz-txt-link-rfc2396E" href="http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz">"http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"</a>
</pre>
    </blockquote>
    <div class="moz-signature">-- <br>
      <div style="margin-bottom: 7px; font-family: sans-serif;"> <a
          href="http://inango.com"> <img
            src="cid:part1.F39CC919.5FB96E25@inango-systems.com"> </a>
      </div>
      <div style="color: #333333; padding-left:13px; font-family:
        sans-serif; font-size: 13px; line-height: 14px; ">
        <div style="font-weight: bold;">Nikolai Merinov</div>
        <div>Team Leader, 3rd Party Group</div>
        <div style="font-size: 11px;"><a class="moz-txt-link-abbreviated" href="mailto:n.merinov@inango-systems.com">n.merinov@inango-systems.com</a></div>
        <div style="font-size: 11px; line-height: 15px;
          padding-left:5px">T +7 343 298 0147 C +7 912 229 2564</div>
      </div>
      <div style="margin-left: 13px; font-family: sans-serif; font-size:
        11px; line-height: 14px;">
        <span><a href="http://inango.com" style="text-decoration: none;
            color: #F48B00; font-weight: bold; margin-right: 5px;">inango.com</a></span><a
          href="https://www.linkedin.com/company/inango"><img
            src="cid:part4.FC4E8D4B.C61D8B2A@inango-systems.com"
            alt="Inango on LinkedIn" style="vertical-align: top;"></a>
      </div>
    </div>
  </body>
</html>

--------------0B1BFA8A7A45AC0C158AFC08
Content-Type: image/png;
 name="ecenobkadjnjjdlh.png"
Content-Transfer-Encoding: base64
Content-ID: <part1.F39CC919.5FB96E25@inango-systems.com>
Content-Disposition: inline;
 filename="ecenobkadjnjjdlh.png"

iVBORw0KGgoAAAANSUhEUgAAAI4AAAA2CAMAAAAmulEiAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA
GXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAGNQTFRFHR0bKiooODg3R0dFVVVT
Y2NicXFwf39+jo6NnJybqqqpuLi3xsbG1NTU4+Pi8fHx9IsA9ZIP9Zkf9qAv96g/969P+LZf+b1v
+cV/+syP+9Of/Nuv/OK//enP/vDf/vjv////O48IWgAAA6JJREFUWMPNmGF7oyoQhQ+CiApC2202
Mbl6/v+v3A9RRKPNuk9vDZ/62DPwMgwzQ8CXGhj/uPYvhcP2xXC6l8Lh+bVw2v9eCqf/JEnepi/X
I3F4vpHsLyPdte0Pxel/TUfWn393xx4WeW7JE0l2x8AscPqP0/t7z+506g4O5dvlRt5CCOH9OJjU
O9fT51sIIYTTa1x0diGEEMLni+D07yGEED5ur4DTnz9+hxDC++1yavujcc6fV/L29vZxIdkdxTPg
tKf7CX2OpeJI77TnIVy6y1AqDsRpz11a1Ptjb9Y1SXqXWEnHYa21zaOZtdauzreud9Za69f0bm4w
KxJsqQr2J5KqIGkVAADZbOmmyIbPxbTCF3pvBn1uSSq18h9ZreLcCHVvU6HoNZAbWxsJ5JOmEoAs
jCkkIFzc1qbeZUBubGUkUJCYVqzFZCDdCg4JdW9TobxEPuy+AopIA+SDc62CaKLdht6JSS+hE5xk
JieHna3itB2hDComloMfvICZnC3jsl/odao3EcciMaCG8Fs4PBOZ0EzVw7olVBq4kKPdhl7P9D4T
ESebPEiSCvkmTtvhThuPeVw3T7eURMKGvgFm96zGaFEhmy3cCLgtHN4wZ4/rZvPpE5xVfQk9nz8b
LeR8X2QBvYnDePjDEIPQmNkdTnBW9Qr1clEMbhPLDATxFc78u8JaEjMJzqoeWCQ/OwirNBeMjnPb
ONlzHKcx4azrH3zQDBYGZjldDruNo7ZxXG0KpTIAasJZ1y8/RzfmsI+uNvtxfCnvhUDlxvKfcdT3
4HgJ5FUsh09xHgP2O3G8hPKrF139XSjXMXbKJY5GvRdHLy7EM5zNi14u8hRJuT+UxTwLumc4xVYa
tMureM9hO3FijRor2BMctygSVUwNYhk8JfL9OGo95W+GvpqdrhfRolhY+AzVfhyxXhA3cZpFgzGG
MhsxD6sCGXfjZKmLnXiaBskKUE3sI5P2q0x6SbIC7H4cgyzGghWiiRd5O4vXApDGmCIDTFrcNESZ
FL+K+3G8hDCOpK81hKOENNWTohIbdO3mtbYAZOVIW2ZjZ7g7K2uMQ3vSCdyVX9U40ltr3WOtHV8e
U9OM3S+zpsyVUnnpx4eS32Nt59yuNEqZqll/Z33/MGaJk//1b4P/xyt3UbT0Y636SRw1b4mbZRP7
wzjz7ML8sQH6URwvEx6v53A/j0MvAV03JJ0REDWPxUkzVSwXB+KQTamVUkqXzfOLyJcafwDne07J
Qv7f1QAAAABJRU5ErkJggg==

--------------0B1BFA8A7A45AC0C158AFC08
Content-Type: image/png;
 name="ipblnieilfjhndhp.png"
Content-Transfer-Encoding: base64
Content-ID: <part4.FC4E8D4B.C61D8B2A@inango-systems.com>
Content-Disposition: inline;
 filename="ipblnieilfjhndhp.png"

iVBORw0KGgoAAAANSUhEUgAAADgAAAAQCAIAAADMGysSAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA
GXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAj9JREFUeNrUlk9u2lAQxgvKFi4Q
k33tLFiaHABzAHD2gQtADoC9SyJhFlFXOE23AfYpuQDsEb6AnQMUDkB/ZRrL4RmMlEo0I3gaxm/e
++abPya3Xq+/fAbJHRGo43SDYLF/j64bjuMeE+jDg++6ziE7n55GlUolj2bbdT6LxbvgOp32aDTc
5ZzqkikciBdEoi+XSzFWq1ahUMj0PeE7m82Snsh0Oh2PR5PJT8uqFYtF1U11OUSiKBLHWIDoeX3Y
7fe9bKCqQHWv51EfqSj/oaxWK8uqvr5GmTvzqVZySppct4siWYZj1lqtulUPkNpqNXnEGkUhBWMY
X/mgCN+cwKOzMw2LWiqnp5pt26ZporfbnXq9gcKKvlUP6YxyR5xcUS4vG/Lo+roD38lSfnmZcOjj
4w+4gSGxUzngHg7HoBTCsKgXlUoamKSWUDah/vmpaSXTrMSX7mRUFU4ZDHzRw/BvpqAclJtB487n
c0HZ7TpCDHf7/kBQEsnz84S+2X8L+Ij24qIC90k6djKqSrPZUus1CAJWEtdo2DD3ht7Z2oD4/nfD
MDhEAtvdbaFEq7ZpPnHoYvom6hGpXSUMwRyFCw4xwijcQyrzr1wux9xz9555t5WrfV2fZII7DqR5
ufwFUEbj/f03MXpeT9oZeiDy9vYGHWrPz/WPzIf8B+cLU5D6A8rd3Q3h0cWrjaBItdBP6NLgV1dN
tWtJYBiGMrzjN6qk97941zPhM4f89iv0KALfup5dDOyR6s99lr95vwUYAPJDV32BeqY/AAAAAElF
TkSuQmCC

--------------0B1BFA8A7A45AC0C158AFC08--

--------------20F3260D48578299BD4DD648--
