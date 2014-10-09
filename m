Return-Path: <alejandro.hernandez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7FD9165D58
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Oct 2014 20:22:21 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 09 Oct 2014 13:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
	d="scan'208,217";a="397822637"
Received: from aehernan-devstation.zpn.intel.com (HELO [10.219.4.60])
	([10.219.4.60])
	by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2014 13:15:15 -0700
Message-ID: <5436EE92.1010308@linux.intel.com>
Date: Thu, 09 Oct 2014 15:22:42 -0500
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To: Christopher Larson <clarson@kergoth.com>
References: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
	<CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com>
In-Reply-To: <CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 09 Oct 2014 20:22:27 -0000
Content-Type: multipart/alternative;
	boundary="------------070805080502050304080406"

--------------070805080502050304080406
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

It does not change behavior but it forces the value to be a string, 
avoiding related problems when performing comparisons on "strict", 
another option as Richard Purdie suggested would be to import the 
boolean function from /meta/lib/oe/types.py in OE-Core into a new types 
module in bitbake, forcing it to get a "good" value that we could then use.

On 08/10/14 11:13, Christopher Larson wrote:
>
> On Tue, Sep 30, 2014 at 9:21 AM, Alejandro Hernandez 
> <alejandro.hernandez@linux.intel.com 
> <mailto:alejandro.hernandez@linux.intel.com>> wrote:
>
>     Forcing strict to be a string, to avoid problems when performing
>     comparisons
>
>     [YOCTO #6762]
>
>     Signed-off-by: Alejandro Hernandez
>     <alejandro.hernandez@linux.intel.com
>     <mailto:alejandro.hernandez@linux.intel.com>>
>     ---
>      lib/bb/fetch2/__init__.py | 4 ++--
>      1 file changed, 2 insertions(+), 2 deletions(-)
>
>     diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>     index df2f2b0..10c3346 100644
>     --- a/lib/bb/fetch2/__init__.py
>     +++ b/lib/bb/fetch2/__init__.py
>     @@ -543,8 +543,8 @@ def verify_checksum(ud, d):
>
>          if ud.method.recommends_checksum(ud):
>              # If strict checking enabled and neither sum defined,
>     raise error
>     - strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
>     -        if strict and not (ud.md5_expected or ud.sha256_expected):
>     + strict = d.getVar("BB_STRICT_CHECKSUM", "1") or "0"
>     +        if (strict == "1") and not (ud.md5_expected or
>     ud.sha256_expected):
>
>
> Why was True (second argument of getVar) changed to "1" here? It 
> violates our conventions and doesn't actually change anything in the 
> behavior.
> -- 
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics


--------------070805080502050304080406
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    It does not change behavior but it forces the value to be a string,
    avoiding related problems when performing comparisons on "strict",
    another option as Richard Purdie suggested would be to import the
    boolean function from /meta/lib/oe/types.py in OE-Core into a new
    types module in bitbake, forcing it to get a "good" value that we
    could then use.<br>
    <br>
    <div class="moz-cite-prefix">On 08/10/14 11:13, Christopher Larson
      wrote:<br>
    </div>
    <blockquote
cite="mid:CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Tue, Sep 30, 2014 at 9:21 AM,
            Alejandro Hernandez <span dir="ltr">&lt;<a
                moz-do-not-send="true"
                href="mailto:alejandro.hernandez@linux.intel.com"
                target="_blank">alejandro.hernandez@linux.intel.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div id=":b1" class="a3s" style="overflow:hidden">Forcing
                <span class="il">strict</span> to be a string, to avoid
                problems when performing comparisons<br>
                <br>
                [YOCTO #6762]<br>
                <br>
                Signed-off-by: Alejandro Hernandez &lt;<a
                  moz-do-not-send="true"
                  href="mailto:alejandro.hernandez@linux.intel.com">alejandro.hernandez@linux.intel.com</a>&gt;<br>
                ---<br>
                 lib/bb/fetch2/__init__.py | 4 ++--<br>
                 1 file changed, 2 insertions(+), 2 deletions(-)<br>
                <br>
                diff --git a/lib/bb/fetch2/__init__.py
                b/lib/bb/fetch2/__init__.py<br>
                index df2f2b0..10c3346 100644<br>
                --- a/lib/bb/fetch2/__init__.py<br>
                +++ b/lib/bb/fetch2/__init__.py<br>
                @@ -543,8 +543,8 @@ def verify_checksum(ud, d):<br>
                <br>
                     if ud.method.recommends_checksum(ud):<br>
                         # If <span class="il">strict</span> checking
                enabled and neither sum defined, raise error<br>
                -        <span class="il">strict</span> =
                d.getVar("BB_STRICT_CHECKSUM", True) or None<br>
                -        if <span class="il">strict</span> and not
                (ud.md5_expected or ud.sha256_expected):<br>
                +        <span class="il">strict</span> =
                d.getVar("BB_STRICT_CHECKSUM", "1") or "0"<br>
                +        if (<span class="il">strict</span> == "1") and
                not (ud.md5_expected or ud.sha256_expected):</div>
            </blockquote>
          </div>
          <br>
          Why was True (second argument of getVar) changed to "1" here?
          It violates our conventions and doesn't actually change
          anything in the behavior.<br>
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

--------------070805080502050304080406--
