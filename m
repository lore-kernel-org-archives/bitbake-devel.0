Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
	[209.85.215.176])
	by mail.openembedded.org (Postfix) with ESMTP id A6FB47D2DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 15:39:24 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id f6so5378723pgs.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=YRHuWG/B2xgkZElivKcgyoABBZu/UvEn/n/9RvaGG1o=;
	b=eNw4AtvGbycg0JDtTmlyta39DtQnULIsk8Nma0yOfr4jf5t2ORsSl2IKsWpsZGcOp2
	UCLwFiYEms4t4H93Ua3o6ceFxyrCiT/azzvk2C6Vvsi0xzmFclUapIZGT+ls0hkyU88l
	8h+L4aLRi6RvKuI9zPWoZZnH/5wVtQ+56oR2xnOvDCatCxgUYiB7oedjj0sZY7eBfZzZ
	0FzdJeMlvINGutHMVZYe2PR/BtfRTBTEP+lGkvHleVdhbY0X3MGHhA/TCHmOBnAGwPO9
	3wZIX/GaCKU2CeN0ovarvU/5s3HLG5hxZZirRWXeHLKT+R7n7Ri2OpS2T8lxTd+d0ND7
	FnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language;
	bh=YRHuWG/B2xgkZElivKcgyoABBZu/UvEn/n/9RvaGG1o=;
	b=kaFguI9TKiQ/roROI44TMfKUSUYfL79YGT1PozEfPGLgCjc+GGwZZWG90A8K8QSAs8
	LCSmNIAsg/2UKq7/WChFVKrwDoK8SpkPPOc1MDZHVnVFjIXjaev063VlKfGlQFva8dkt
	weDYjgCigZzhZ0KdAi6bLx3eKQc7GEniTRBZy+QLeb5P2wg5YnbT0Sm9uR8NMK0dZEGT
	jFOSkzGgMxfoJX+Ru5bQIs6uNc9qiNtomeWPXjcMKrdQ9cv6fHMzizRxAPSI6ztBFIf+
	M5rQMJfOYUqvglHF2Zk//DA8lj7H6960aauB8WXXVXRJX0xW2fKkKWnYFCj2/jEQZmS+
	H/Ng==
X-Gm-Message-State: APjAAAV+JcwloOY+t0GfZSabnGsCIZKl+DkUngQH66Dhg7CNyt2ztahB
	uLui/qV9lnWX+o+2YK4vfmhP41Iv
X-Google-Smtp-Source: APXvYqz4m40UrhiEv0apIOduWwSUguzYaFyG5bWBYwhxyrLUksPvMOZQk9EfgQqehOlNampwB48VZA==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr2591886pff.135.1555083565029; 
	Fri, 12 Apr 2019 08:39:25 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:3979:dabc:ad30:adf?
	([2601:202:4180:c33:3979:dabc:ad30:adf])
	by smtp.gmail.com with ESMTPSA id
	25sm17154890pfo.145.2019.04.12.08.39.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 08:39:24 -0700 (PDT)
To: Martin Jansa <martin.jansa@gmail.com>, akuster <akuster@mvista.com>
References: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
	<CABcZAN=v6z1wYty0EbjVAtAKeR_EQgzRuZcYYXLBOWxh4m=-qw@mail.gmail.com>
	<79d20dc2-8f36-3c27-05e5-3517b2eb8e26@mvista.com>
	<CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <1c452d27-33c3-234b-9d57-b39689d3c3f9@gmail.com>
Date: Fri, 12 Apr 2019 08:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH]] bitbake: update masters version to some farout version
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
X-List-Received-Date: Fri, 12 Apr 2019 15:39:24 -0000
Content-Type: multipart/alternative;
	boundary="------------32E85E342B331F9FE6CFE566"
Content-Language: en-US

--------------32E85E342B331F9FE6CFE566
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 4/12/19 1:06 PM, Martin Jansa wrote:
> > but so how is it Master is 1.40
>
> It isn't, master is currently identical with 1.42 branch, so both are
> 1.42.
Yes you are correct. As of this email it is.

Three hours ago master was updated to 1.42
https://git.openembedded.org/bitbake/commit/?id=00b133af009f9e7c1a4c751b6ef4902f47a81fe2

Master then got bumped to 1.43
https://git.openembedded.org/bitbake/commit/?id=aae15f3c16fb463962eee100a8b0bcd5fc01ad96

again three hours ago.

so now all it right with the world. : )

- armin
>
> Setting it farout, will cause issues once new incompatible change is
> introduced in the metadata and the sanity check needs to be updated to
> require even more farout version.
>
> On Fri, Apr 12, 2019 at 8:04 AM akuster <akuster@mvista.com
> <mailto:akuster@mvista.com>> wrote:
>
>
>
>     On 4/12/19 8:23 AM, Christopher Larson wrote:
>>     My concern here is a user of an old clone of bitbake master won't
>>     trigger the oe-core bitbake version checks, it could just
>>     silently behave badly, or explode instead :)
>     ok. but so how is it Master is 1.40 and Warrior is 1.42 isn't
>     causing a version trigger?
>
>     Is the version in the __init__.py needed ?  Warriors does not
>     match and I have not seen any version check issues.
>
>     as always, thanks for the feedback,
>     Dazed and confused
>
>>
>>     On Thu, Apr 11, 2019 at 6:20 PM Armin Kuster
>>     <akuster808@gmail.com <mailto:akuster808@gmail.com>> wrote:
>>
>>         This is to avoid having master being updated when we branch
>>         for a new release.
>>
>>         Also, master should not be at the same version as the last
>>         stable release.
>>
>>         Signed-off-by: Armin Kuster <akuster808@gmail.com
>>         <mailto:akuster808@gmail.com>>
>>         ---
>>          bin/bitbake        | 2 +-
>>          lib/bb/__init__.py | 2 +-
>>          2 files changed, 2 insertions(+), 2 deletions(-)
>>
>>         diff --git a/bin/bitbake b/bin/bitbake
>>         index 57dec2a..952c47e 100755
>>         --- a/bin/bitbake
>>         +++ b/bin/bitbake
>>         @@ -38,7 +38,7 @@ from bb.main import bitbake_main,
>>         BitBakeConfigParameters, BBMainException
>>          if sys.getfilesystemencoding() != "utf-8":
>>              sys.exit("Please use a locale setting which supports
>>         UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the
>>         filesystem locale after loading so we need a UTF-8 when
>>         Python starts or things won't work.")
>>
>>         -__version__ = "1.40.0"
>>         +__version__ = "1.99.0"
>>
>>          if __name__ == "__main__":
>>              if __version__ != bb.__version__:
>>         diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
>>         index 4bc47c8..a86197a 100644
>>         --- a/lib/bb/__init__.py
>>         +++ b/lib/bb/__init__.py
>>         @@ -21,7 +21,7 @@
>>          # with this program; if not, write to the Free Software
>>         Foundation, Inc.,
>>          # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>
>>         -__version__ = "1.40.0"
>>         +__version__ = "1.99.0"
>>
>>          import sys
>>          if sys.version_info < (3, 4, 0):
>>         -- 
>>         2.7.4
>>
>>         -- 
>>         _______________________________________________
>>         bitbake-devel mailing list
>>         bitbake-devel@lists.openembedded.org
>>         <mailto:bitbake-devel@lists.openembedded.org>
>>         http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>>
>>
>>     -- 
>>     Christopher Larson
>>     kergoth at gmail dot com
>>     Founder - BitBake, OpenEmbedded, OpenZaurus
>>     Senior Software Engineer, Mentor Graphics
>>
>
>     -- 
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


--------------32E85E342B331F9FE6CFE566
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 4/12/19 1:06 PM, Martin Jansa wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">&gt; but so how is it Master is 1.40
        <div><br>
        </div>
        <div>It isn't, master is currently identical with 1.42 branch,
          so both are 1.42.</div>
      </div>
    </blockquote>
    Yes you are correct. As of this email it is.<br>
    <br>
    Three hours ago master was updated to 1.42<br>
<a class="moz-txt-link-freetext" href="https://git.openembedded.org/bitbake/commit/?id=00b133af009f9e7c1a4c751b6ef4902f47a81fe2">https://git.openembedded.org/bitbake/commit/?id=00b133af009f9e7c1a4c751b6ef4902f47a81fe2</a><br>
    <br>
    Master then got bumped to 1.43<br>
<a class="moz-txt-link-freetext" href="https://git.openembedded.org/bitbake/commit/?id=aae15f3c16fb463962eee100a8b0bcd5fc01ad96">https://git.openembedded.org/bitbake/commit/?id=aae15f3c16fb463962eee100a8b0bcd5fc01ad96</a><br>
    <br>
    again three hours ago.<br>
    <br>
    so now all it right with the world. : )<br>
    <br>
    - armin<br>
    <blockquote type="cite"
cite="mid:CA+chaQc3w=8kPabdEt1Jz-O=5GfuUL0XZ6Y=Eyx27kFTxHwZYw@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Setting it farout, will cause issues once new incompatible
          change is introduced in the metadata and the sanity check
          needs to be updated to require even more farout version.</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Apr 12, 2019 at 8:04
          AM akuster &lt;<a href="mailto:akuster@mvista.com"
            moz-do-not-send="true">akuster@mvista.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor="#FFFFFF"> <br>
            <br>
            <div class="gmail-m_3620003381146642744moz-cite-prefix">On
              4/12/19 8:23 AM, Christopher Larson wrote:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">My concern here is a user of an old clone
                of bitbake master won't trigger the oe-core bitbake
                version checks, it could just silently behave badly, or
                explode instead :)</div>
            </blockquote>
            ok. but so how is it Master is 1.40 and Warrior is 1.42
            isn't causing a version trigger? <br>
            <br>
            Is the version in the __init__.py needed ?  Warriors does
            not match and I have not seen any version check issues.<br>
            <br>
            as always, thanks for the feedback, <br>
            Dazed and confused<br>
            <br>
            <blockquote type="cite"><br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Thu, Apr 11, 2019
                  at 6:20 PM Armin Kuster &lt;<a
                    href="mailto:akuster808@gmail.com" target="_blank"
                    moz-do-not-send="true">akuster808@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">This is to avoid
                  having master being updated when we branch<br>
                  for a new release.<br>
                  <br>
                  Also, master should not be at the same version as the
                  last<br>
                  stable release.<br>
                  <br>
                  Signed-off-by: Armin Kuster &lt;<a
                    href="mailto:akuster808@gmail.com" target="_blank"
                    moz-do-not-send="true">akuster808@gmail.com</a>&gt;<br>
                  ---<br>
                   bin/bitbake        | 2 +-<br>
                   lib/bb/__init__.py | 2 +-<br>
                   2 files changed, 2 insertions(+), 2 deletions(-)<br>
                  <br>
                  diff --git a/bin/bitbake b/bin/bitbake<br>
                  index 57dec2a..952c47e 100755<br>
                  --- a/bin/bitbake<br>
                  +++ b/bin/bitbake<br>
                  @@ -38,7 +38,7 @@ from bb.main import bitbake_main,
                  BitBakeConfigParameters, BBMainException<br>
                   if sys.getfilesystemencoding() != "utf-8":<br>
                       sys.exit("Please use a locale setting which
                  supports UTF-8 (such as LANG=en_US.UTF-8).\nPython
                  can't change the filesystem locale after loading so we
                  need a UTF-8 when Python starts or things won't
                  work.")<br>
                  <br>
                  -__version__ = "1.40.0"<br>
                  +__version__ = "1.99.0"<br>
                  <br>
                   if __name__ == "__main__":<br>
                       if __version__ != bb.__version__:<br>
                  diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py<br>
                  index 4bc47c8..a86197a 100644<br>
                  --- a/lib/bb/__init__.py<br>
                  +++ b/lib/bb/__init__.py<br>
                  @@ -21,7 +21,7 @@<br>
                   # with this program; if not, write to the Free
                  Software Foundation, Inc.,<br>
                   # 51 Franklin Street, Fifth Floor, Boston, MA
                  02110-1301 USA.<br>
                  <br>
                  -__version__ = "1.40.0"<br>
                  +__version__ = "1.99.0"<br>
                  <br>
                   import sys<br>
                   if sys.version_info &lt; (3, 4, 0):<br>
                  -- <br>
                  2.7.4<br>
                  <br>
                  -- <br>
                  _______________________________________________<br>
                  bitbake-devel mailing list<br>
                  <a href="mailto:bitbake-devel@lists.openembedded.org"
                    target="_blank" moz-do-not-send="true">bitbake-devel@lists.openembedded.org</a><br>
                  <a
                    href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
                </blockquote>
              </div>
              <br clear="all">
              <div><br>
              </div>
              -- <br>
              <div dir="ltr"
                class="gmail-m_3620003381146642744gmail_signature">
                <div dir="ltr">
                  <div>
                    <div dir="ltr">Christopher Larson<br>
                      kergoth at gmail dot com<br>
                      Founder - BitBake, OpenEmbedded, OpenZaurus<br>
                      Senior Software Engineer, Mentor Graphics</div>
                  </div>
                </div>
              </div>
              <br>
              <fieldset
                class="gmail-m_3620003381146642744mimeAttachmentHeader"></fieldset>
            </blockquote>
            <br>
          </div>
          -- <br>
          _______________________________________________<br>
          bitbake-devel mailing list<br>
          <a href="mailto:bitbake-devel@lists.openembedded.org"
            target="_blank" moz-do-not-send="true">bitbake-devel@lists.openembedded.org</a><br>
          <a
            href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
            rel="noreferrer" target="_blank" moz-do-not-send="true">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------32E85E342B331F9FE6CFE566--
