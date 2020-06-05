Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.5958.1591342150581396507
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 00:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=FCbmud3l;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: alhe@linux.microsoft.com)
Received: from [192.168.1.246] (cpe-68-201-52-49.elp.res.rr.com [68.201.52.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AA0620B7185;
	Fri,  5 Jun 2020 00:29:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AA0620B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1591342149;
	bh=rMvk9By7sMniuIrWOX4KXGNl3s5LuJAZi4WsIIROGog=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=FCbmud3lvYo+ZDYeKMb2/6pjAWYoS8c9P3XegTAF4+S4Q68M7lJGdsJa9jwa0LQQZ
	 vfT7HIQU9fZ6gSCxLAdMQHDXLvGr/jChz9eveKQjmGBGoHY5G5lPyl8RiAoi0Mb/dm
	 sitXYdjlAzLdnztv7jxVyaHgX8X+U1Q2dp2T1nBg=
Subject: Re: [bitbake-devel][PATCH v4 0/8] Add support for per-multiconfig BBMASK
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
From: "Alejandro Hernandez" <alhe@linux.microsoft.com>
Message-ID: <09fa0315-1536-1896-a4a4-f3771637ba17@linux.microsoft.com>
Date: Fri, 5 Jun 2020 00:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------056B944F0C3BD3A0AA3DB7AF"
Content-Language: en-US

--------------056B944F0C3BD3A0AA3DB7AF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Joshua,

Interesting approach, it looks good, it does look like the next step 
that has to be taken, initially this would have been too invasive but I 
think this should be fine.

Do you have data on the performance increase/decrease by using multiple 
caches?, are there any implications?


Cheers,

Alejandro


On 6/4/20 6:53 PM, Joshua Watt wrote:
> Splits apart the bitbake configuration data and caches so that each
> defined multiconfig can specify as separate BBMASK independently of the
> other multiconfigs. This can take multiple forms, such as a `BBMASK` in
> a multiconfig .conf file, or BBMASK assignment based on an override (see
> linked bugzilla for an example).
>
> The most noticeable change is that bitbake now keeps a parsing cache
> file for each multiconfig instead of a single parsing cache file that
> caches all multiconfigs.
>
> [YOCTO #13721]
>
> V2: Fixes some syntax errors in tinfoil
>
> V3: Optimizes caches so that each one only caches the files for it's own
> multiconfig
>
> V4: Fixes compatability with Python < 3.6
>      Renames split_pn -> split_mc
>
> Joshua Watt (8):
>    bitbake: cooker: Split file collections per multiconfig
>    bitbake: cache: Use multiconfig aware caches
>    bitbake: lib: Add support for Logging Adapters
>    bitbake: lib: Add PrefixLoggerAdapter helper
>    bitbake: cache: Improve logging
>    bitbake: cache: Cache size optimization
>    bitbake: tests: Add tests for BBMASK in multiconfig
>    bitbake: command: Move split_mc_pn to runqueue
>
>   bitbake/lib/bb/__init__.py                    |  50 +++-
>   bitbake/lib/bb/cache.py                       | 228 ++++++++++++------
>   bitbake/lib/bb/command.py                     |  39 +--
>   bitbake/lib/bb/cooker.py                      | 159 +++++++-----
>   bitbake/lib/bb/runqueue.py                    |  17 +-
>   .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
>   .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
>   .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
>   .../recipes/fails-mc/fails-mc1.bb             |   5 +
>   .../recipes/fails-mc/fails-mc2.bb             |   4 +
>   bitbake/lib/bb/tests/runqueue.py              |  15 ++
>   bitbake/lib/bb/tinfoil.py                     |  26 +-
>   bitbake/lib/bblayers/query.py                 |   4 +-
>   13 files changed, 380 insertions(+), 172 deletions(-)
>   create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
>   create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
>
>
> 

--------------056B944F0C3BD3A0AA3DB7AF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hey Joshua,</p>
    <p>Interesting approach, it looks good, it does look like the next
      step that has to be taken, initially this would have been too
      invasive but I think this should be fine.</p>
    <p>Do you have data on the performance increase/decrease by using
      multiple caches?, are there any implications?</p>
    <p><br>
    </p>
    <p>Cheers,</p>
    <p>Alejandro<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/4/20 6:53 PM, Joshua Watt wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200605015325.35395-1-JPEWhacker@gmail.com">
      <pre class="moz-quote-pre" wrap="">Splits apart the bitbake configuration data and caches so that each
defined multiconfig can specify as separate BBMASK independently of the
other multiconfigs. This can take multiple forms, such as a `BBMASK` in
a multiconfig .conf file, or BBMASK assignment based on an override (see
linked bugzilla for an example).

The most noticeable change is that bitbake now keeps a parsing cache
file for each multiconfig instead of a single parsing cache file that
caches all multiconfigs.

[YOCTO #13721]

V2: Fixes some syntax errors in tinfoil

V3: Optimizes caches so that each one only caches the files for it's own
multiconfig

V4: Fixes compatability with Python &lt; 3.6
    Renames split_pn -&gt; split_mc

Joshua Watt (8):
  bitbake: cooker: Split file collections per multiconfig
  bitbake: cache: Use multiconfig aware caches
  bitbake: lib: Add support for Logging Adapters
  bitbake: lib: Add PrefixLoggerAdapter helper
  bitbake: cache: Improve logging
  bitbake: cache: Cache size optimization
  bitbake: tests: Add tests for BBMASK in multiconfig
  bitbake: command: Move split_mc_pn to runqueue

 bitbake/lib/bb/__init__.py                    |  50 +++-
 bitbake/lib/bb/cache.py                       | 228 ++++++++++++------
 bitbake/lib/bb/command.py                     |  39 +--
 bitbake/lib/bb/cooker.py                      | 159 +++++++-----
 bitbake/lib/bb/runqueue.py                    |  17 +-
 .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
 .../recipes/fails-mc/fails-mc1.bb             |   5 +
 .../recipes/fails-mc/fails-mc2.bb             |   4 +
 bitbake/lib/bb/tests/runqueue.py              |  15 ++
 bitbake/lib/bb/tinfoil.py                     |  26 +-
 bitbake/lib/bblayers/query.py                 |   4 +-
 13 files changed, 380 insertions(+), 172 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------056B944F0C3BD3A0AA3DB7AF--
