Return-Path: <alejandro.hernandez@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id EC7106FDEB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Oct 2014 20:38:19 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 09 Oct 2014 13:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,687,1406617200"; 
	d="scan'208,217";a="603013697"
Received: from aehernan-devstation.zpn.intel.com (HELO [10.219.4.60])
	([10.219.4.60])
	by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2014 13:38:19 -0700
Message-ID: <5436F25E.7080205@linux.intel.com>
Date: Thu, 09 Oct 2014 15:38:54 -0500
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: Christopher Larson <clarson@kergoth.com>
References: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
	<CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com>
	<5436EE92.1010308@linux.intel.com>
	<CABcZANnpRcOBo7wSoVoHh3P7KB717LoJ9UySKE0TPiEh-cthkQ@mail.gmail.com>
In-Reply-To: <CABcZANnpRcOBo7wSoVoHh3P7KB717LoJ9UySKE0TPiEh-cthkQ@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Thu, 09 Oct 2014 20:38:23 -0000
Content-Type: multipart/alternative;
	boundary="------------040007070100060206040700"

--------------040007070100060206040700
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

That is very true, I will fix that, thanks for pointing it out.

On 09/10/14 15:27, Christopher Larson wrote:
>
> On Thu, Oct 9, 2014 at 1:22 PM, Alejandro Hernandez 
> <alejandro.hernandez@linux.intel.com 
> <mailto:alejandro.hernandez@linux.intel.com>> wrote:
>
>     It does not change behavior but it forces the value to be a
>     string, avoiding related problems when performing comparisons on
>     "strict", another option as Richard Purdie suggested would be to
>     import the boolean function from /meta/lib/oe/types.py in OE-Core
>     into a new types module in bitbake, forcing it to get a "good"
>     value that we could then use.
>
>
> No, that's incorrect. The second argument of getVar is a boolean 
> argument named 'expand', which controls whether you get an expanded or 
> unexpanded value. You're now passing a string in boolean context.
> -- 
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics


--------------040007070100060206040700
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    That is very true, I will fix that, thanks for pointing it out.<br>
    <br>
    <div class="moz-cite-prefix">On 09/10/14 15:27, Christopher Larson
      wrote:<br>
    </div>
    <blockquote
cite="mid:CABcZANnpRcOBo7wSoVoHh3P7KB717LoJ9UySKE0TPiEh-cthkQ@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Thu, Oct 9, 2014 at 1:22 PM,
            Alejandro Hernandez <span dir="ltr">&lt;<a
                moz-do-not-send="true"
                href="mailto:alejandro.hernandez@linux.intel.com"
                target="_blank">alejandro.hernandez@linux.intel.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">It does
              not change behavior but it forces the value to be a
              string, avoiding related problems when performing
              comparisons on "strict", another option as Richard Purdie
              suggested would be to import the boolean function from
              /meta/lib/oe/types.py in OE-Core into a new types module
              in bitbake, forcing it to get a "good" value that we could
              then use.</blockquote>
          </div>
          <br>
          No, that's incorrect. The second argument of getVar is a
          boolean argument named 'expand', which controls whether you
          get an expanded or unexpanded value. You're now passing a
          string in boolean context.<br>
          -- <br>
          Christopher Larson<br>
          clarson at kergoth dot com<br>
          Founder - BitBake, OpenEmbedded, OpenZaurus<br>
          Maintainer - Tslib<br>
          Senior Software Engineer, Mentor Graphics
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------040007070100060206040700--
