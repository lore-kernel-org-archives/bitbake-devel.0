Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
	[209.85.210.170])
	by mail.openembedded.org (Postfix) with ESMTP id 45DD36D13A
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Mar 2019 01:12:53 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id p10so3973996pff.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=c0Rx0gpx/UXEuYtmzvuG9TMXAC4hR7C2x7BAryjF6Vc=;
	b=LtloyEVNvKViLrm6sdg/dlKGvsiQKOgVfLOM4TLw34T7pWK/4Vc8MDGB0PdFbrHjon
	yHJfHmgW0RRMBS9l8pukhbClxdfMY6P0MC4YAtHaeqj04Tm8WfAnDHrgQ2JoClzXfMV2
	0+lZ9OLDZLlre+j/jzZL5y65Hy+EX+f+YKbxj1GahEQ29yyoRIka8cjRhGa7WyEwmQr3
	GFGgtjs3jT/UCQatrnySHNkpJ7/T77I5uD0rfhGHVws1HGfV80Q1lONVVpZOUvtBKbGC
	gffZuJopQcVzwa/yrqHIhVjq0GQSZjIoscf/3p7vXGScM7G+0GKKIkCGFe4Rlys9b4yG
	dORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language;
	bh=c0Rx0gpx/UXEuYtmzvuG9TMXAC4hR7C2x7BAryjF6Vc=;
	b=OYSTCPOyFvN0FmdrlX/4TRfeXhtrsgRTT4yqC/y5Bilt5EI8+C+ZU8oevci4HN05Mn
	yZIfBNUDvBSNl7aC+sVo5nnOOf1JbqrkiVdJBKsvBeBAHuCtZzEzT1rHkOadK3Q52/Fi
	8p4zpzF2GcuR+Pygc7Df9lv/qcYOBKqonxg2+pvARcqcpsO9WKAaAkzfVZuciV7yfHdu
	F9GD0dRSMWBd7+qdTDpmwEA0JS5x3PZcrSbpdv9feQ9wuxnPi+NHdQySvUtv3npgM6ZF
	PfLjm2mfaSxDz/+m/J+YG4T5lu7tXSOpvm+7fywXFvIFo67w2DA67uoilhTxqGr/x9WA
	6ufw==
X-Gm-Message-State: APjAAAW1UV85AD/kbx4tX1gqC/qjW25edz0swODNHjXmWu/xhsTHjBMT
	/ma9A02CNMTf/p0j1mQ82OPIrLZ8
X-Google-Smtp-Source: APXvYqzLH9uVE1/tDVL2NgxEysaFz6X/T7YqopB1L7+m9V/hVDQtElHwhszyTxvS+WufpO8REnIoQw==
X-Received: by 2002:a65:4549:: with SMTP id x9mr16841997pgr.3.1553389974078;
	Sat, 23 Mar 2019 18:12:54 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:9ce3:bbbb:72cd:d5f9?
	([2601:202:4180:c33:9ce3:bbbb:72cd:d5f9])
	by smtp.gmail.com with ESMTPSA id
	l12sm25845811pgn.83.2019.03.23.18.12.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Mar 2019 18:12:53 -0700 (PDT)
To: Martin Jansa <martin.jansa@gmail.com>
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
	<5e7ac387-3a30-6fd3-b593-a2636e0cb93e@mvista.com>
	<CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com>
	<1c5e4301-95c9-c004-681a-1b6c3ccb936f@gmail.com>
	<CA+chaQdD2ntrXWWKScSfs5LHNU71pPOQUX0a_rty+OyxAcLfww@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <a2f68b83-026d-218b-fd2e-5ff46c3e0a58@gmail.com>
Date: Sat, 23 Mar 2019 18:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+chaQdD2ntrXWWKScSfs5LHNU71pPOQUX0a_rty+OyxAcLfww@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/12] Sumo pull request
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
X-List-Received-Date: Sun, 24 Mar 2019 01:12:53 -0000
Content-Type: multipart/alternative;
	boundary="------------D355659DE16E08B35F0BD136"
Content-Language: en-US

--------------D355659DE16E08B35F0BD136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 3/23/19 5:03 PM, Martin Jansa wrote:
> This stable/sumo-nmut?
> http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-nmut
>
> I'm sorry, but I still don't see it there.
So true.
The contrib I used to build out of for Yocto AB.

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=stable/sumo-nmut

Sorry, I am in the middle of re-aligning my processes from what was
easier for me to what works better for the community.

it will be corrected soon.

- armin
>
> On Sat, Mar 23, 2019 at 9:58 PM akuster808 <akuster808@gmail.com
> <mailto:akuster808@gmail.com>> wrote:
>
>
>
>     On 3/23/19 1:37 PM, Martin Jansa wrote:
>>     >  Why would I reference patchwork? How does that work if this is
>>     the only message sent out?
>>
>>     I don't want you to reference patchwork.
>>
>>     I'm only asking why you haven't included this change
>>     (http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html
>>     if you don't like the link to patchwork) in the pull request, or
>>     in sumo-next branch when patchwork status says "sumo-next".
>
>     its in the next series. I had build failures that put everything
>     on old for two weeks while I troubleshot the failures  Adding new
>     changes would have just added to the problem.  if you look at
>     stable/sumo-nmut, it has your changes and a few more.
>
>     - armin
>>
>>     On Sat, Mar 23, 2019 at 3:40 PM akuster <akuster@mvista.com
>>     <mailto:akuster@mvista.com>> wrote:
>>
>>
>>
>>         On 3/23/19 1:32 AM, Martin Jansa wrote:
>>>         Hi,
>>>
>>>         is there a reason for not including
>>>         https://patchwork.openembedded.org/patch/159465/
>>>         ?
>>>
>>         Why would I reference patchwork? How does that work if this
>>         is the only message sent out?
>>
>>>         It says sumo-next on patchwork, but I don't know which
>>>         sumo-next it is, I don't see it in:
>>>         http://git.openembedded.org/openembedded-core/log/?h=sumo-next
>>         I don't have write access to core.
>>
>>         the changes are in contrib:
>>         https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>>         - armin
>>>
>>>         On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster
>>>         <akuster808@gmail.com <mailto:akuster808@gmail.com>> wrote:
>>>
>>>             Please consider this for the next sumo update
>>>
>>>             The following changes since commit
>>>             6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>>>
>>>               package_rpm/archiver: Apply bandaid to src.rpm
>>>             creation (2019-02-25 22:13:08 +0000)
>>>
>>>             are available in the git repository at:
>>>
>>>               git://git.openembedded.org/openembedded-core-contrib
>>>             <http://git.openembedded.org/openembedded-core-contrib>
>>>             stable/sumo-next
>>>              
>>>             http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>>>
>>>             Chen Qi (2):
>>>               systemd: fix CVE-2018-15686
>>>               systemd: fix CVE-2018-15688
>>>
>>>             George McCollister (5):
>>>               systemd: fix CVE-2018-15687
>>>               systemd: Security fix CVE-2018-16864
>>>               systemd: Security fix CVE-2018-16865
>>>               systemd: fix CVE-2018-6954
>>>               systemd: fix CVE-2019-6454
>>>
>>>             Marcus Cooper (1):
>>>               systemd: Security fix CVE-2018-16866
>>>
>>>             Mingli Yu (1):
>>>               logrotate.py: restore /etc/logrotate.d/wtmp
>>>
>>>             ROGEZ Matthieu (1):
>>>               systemd: Fix typo in root home variable.
>>>
>>>             Richard Purdie (1):
>>>               oeqa/runtime/dnf: Fix test error when static libs are
>>>             enabled
>>>
>>>             Stefan Agner (1):
>>>               run-postinsts: for dpkg/opkg, do not rely on
>>>             /etc/*-postinsts
>>>
>>>              meta/lib/oeqa/runtime/cases/dnf.py                 |   
>>>             2 +-
>>>              meta/lib/oeqa/runtime/cases/logrotate.py           |   
>>>             6 +-
>>>              ...sive-let-s-rework-the-recursive-logic-to-.patch | 
>>>             252 +++
>>>              ...eserializing-state-always-use-read_line-L.patch | 
>>>             250 +++
>>>              ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>>>              ...n-t-resolve-pathnames-when-traversing-rec.patch | 
>>>             643 +++++++
>>>              .../systemd/systemd/0002-Make-tmpfiles-safe.patch  |
>>>             1828 ++++++++++++++++++++
>>>              ...-not-store-the-iovec-entry-for-process-co.patch | 
>>>             193 +++
>>>              ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>>>              ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>>>              ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>>>              .../systemd/systemd/CVE-2019-6454.patch            | 
>>>             210 +++
>>>              ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>>>              meta/recipes-core/systemd/systemd_237.bb
>>>             <http://systemd_237.bb>           |   13 +-
>>>              .../run-postinsts/run-postinsts/run-postinsts      | 
>>>              21 +-
>>>              .../run-postinsts/run-postinsts.service            |    1 -
>>>              16 files changed, 3694 insertions(+), 13 deletions(-)
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>>>              create mode 100644
>>>             meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>>>
>>>             -- 
>>>             2.7.4
>>>
>>>             -- 
>>>             _______________________________________________
>>>             bitbake-devel mailing list
>>>             bitbake-devel@lists.openembedded.org
>>>             <mailto:bitbake-devel@lists.openembedded.org>
>>>             http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>>
>>>
>>
>


--------------D355659DE16E08B35F0BD136
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/23/19 5:03 PM, Martin Jansa wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQdD2ntrXWWKScSfs5LHNU71pPOQUX0a_rty+OyxAcLfww@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">This stable/sumo-nmut?
          <div><a
href="http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-nmut"
              moz-do-not-send="true">http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-nmut</a><br>
          </div>
          <div><br>
          </div>
          <div>I'm sorry, but I still don't see it there.</div>
        </div>
      </div>
    </blockquote>
    So true.<br>
    The contrib I used to build out of for Yocto AB.<br>
    <br>
<a class="moz-txt-link-freetext" href="http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=stable/sumo-nmut">http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=stable/sumo-nmut</a><br>
    <br>
    Sorry, I am in the middle of re-aligning my processes from what was
    easier for me to what works better for the community.<br>
    <br>
    it will be corrected soon.<br>
    <br>
    - armin<br>
    <blockquote type="cite"
cite="mid:CA+chaQdD2ntrXWWKScSfs5LHNU71pPOQUX0a_rty+OyxAcLfww@mail.gmail.com"><br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019 at 9:58
          PM akuster808 &lt;<a href="mailto:akuster808@gmail.com"
            moz-do-not-send="true">akuster808@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor="#FFFFFF"> <br>
            <br>
            <div class="gmail-m_-6627059004469126089moz-cite-prefix">On
              3/23/19 1:37 PM, Martin Jansa wrote:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div dir="ltr">&gt;  Why would I reference patchwork?
                  How does that work if this is the only message sent
                  out?
                  <div><br>
                  </div>
                  <div>I don't want you to reference patchwork.</div>
                  <div><br>
                  </div>
                  <div>I'm only asking why you haven't included this
                    change (<a
href="http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html"
                      target="_blank" moz-do-not-send="true">http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html</a>
                    if you don't like the link to patchwork) in the pull
                    request, or in sumo-next branch when patchwork
                    status says "sumo-next".</div>
                </div>
              </div>
            </blockquote>
            <br>
            its in the next series. I had build failures that put
            everything on old for two weeks while I troubleshot the
            failures  Adding new changes would have just added to the
            problem.  if you look at stable/sumo-nmut, it has your
            changes and a few more.<br>
            <br>
            - armin<br>
            <blockquote type="cite"><br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019
                  at 3:40 PM akuster &lt;<a
                    href="mailto:akuster@mvista.com" target="_blank"
                    moz-do-not-send="true">akuster@mvista.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div bgcolor="#FFFFFF"> <br>
                    <br>
                    <div
class="gmail-m_-6627059004469126089gmail-m_7305473577171404396moz-cite-prefix">On
                      3/23/19 1:32 AM, Martin Jansa wrote:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">Hi,
                        <div><br>
                        </div>
                        <div>is there a reason for not including</div>
                        <div><a
                            href="https://patchwork.openembedded.org/patch/159465/"
                            target="_blank" moz-do-not-send="true">https://patchwork.openembedded.org/patch/159465/</a><br>
                        </div>
                        <div>?</div>
                        <div><br>
                        </div>
                      </div>
                    </blockquote>
                    Why would I reference patchwork? How does that work
                    if this is the only message sent out?<br>
                    <br>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>It says sumo-next on patchwork, but I don't
                          know which sumo-next it is, I don't see it in:</div>
                        <div><a
                            href="http://git.openembedded.org/openembedded-core/log/?h=sumo-next"
                            target="_blank" moz-do-not-send="true">http://git.openembedded.org/openembedded-core/log/?h=sumo-next</a><br>
                        </div>
                      </div>
                    </blockquote>
                    I don't have write access to core.<br>
                    <br>
                    the changes are in contrib: <a
class="gmail-m_-6627059004469126089gmail-m_7305473577171404396moz-txt-link-freetext"
href="https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
                      target="_blank" moz-do-not-send="true">https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
                    - armin<br>
                    <blockquote type="cite"><br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Sat, Mar
                          23, 2019 at 3:12 AM Armin Kuster &lt;<a
                            href="mailto:akuster808@gmail.com"
                            target="_blank" moz-do-not-send="true">akuster808@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">Please
                          consider this for the next sumo update<br>
                          <br>
                          The following changes since commit
                          6d56e912fbbaa22830b4da5ab230586a3d15b23e:<br>
                          <br>
                            package_rpm/archiver: Apply bandaid to
                          src.rpm creation (2019-02-25 22:13:08 +0000)<br>
                          <br>
                          are available in the git repository at:<br>
                          <br>
                            git://<a
                            href="http://git.openembedded.org/openembedded-core-contrib"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true">git.openembedded.org/openembedded-core-contrib</a>
                          stable/sumo-next<br>
                            <a
href="http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true">http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
                          <br>
                          Chen Qi (2):<br>
                            systemd: fix CVE-2018-15686<br>
                            systemd: fix CVE-2018-15688<br>
                          <br>
                          George McCollister (5):<br>
                            systemd: fix CVE-2018-15687<br>
                            systemd: Security fix CVE-2018-16864<br>
                            systemd: Security fix CVE-2018-16865<br>
                            systemd: fix CVE-2018-6954<br>
                            systemd: fix CVE-2019-6454<br>
                          <br>
                          Marcus Cooper (1):<br>
                            systemd: Security fix CVE-2018-16866<br>
                          <br>
                          Mingli Yu (1):<br>
                            logrotate.py: restore /etc/logrotate.d/wtmp<br>
                          <br>
                          ROGEZ Matthieu (1):<br>
                            systemd: Fix typo in root home variable.<br>
                          <br>
                          Richard Purdie (1):<br>
                            oeqa/runtime/dnf: Fix test error when static
                          libs are enabled<br>
                          <br>
                          Stefan Agner (1):<br>
                            run-postinsts: for dpkg/opkg, do not rely on
                          /etc/*-postinsts<br>
                          <br>
                           meta/lib/oeqa/runtime/cases/dnf.py           
                               |    2 +-<br>
                           meta/lib/oeqa/runtime/cases/logrotate.py     
                               |    6 +-<br>
 ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++<br>
 ...eserializing-state-always-use-read_line-L.patch |  250 +++<br>
 ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +<br>
 ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++<br>
 .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
                          ++++++++++++++++++++<br>
 ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++<br>
 ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +<br>
 ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +<br>
 ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +<br>
                           .../systemd/systemd/CVE-2019-6454.patch     
                                |  210 +++<br>
 ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +<br>
                           meta/recipes-core/systemd/<a
                            href="http://systemd_237.bb"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true">systemd_237.bb</a>   
                                 |   13 +-<br>
 .../run-postinsts/run-postinsts/run-postinsts      |   21 +-<br>
                           .../run-postinsts/run-postinsts.service     
                                |    1 -<br>
                           16 files changed, 3694 insertions(+), 13
                          deletions(-)<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch<br>
                           create mode 100644
                          meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch<br>
                           create mode 100644
                          meta/recipes-core/systemd/systemd/CVE-2019-6454.patch<br>
                           create mode 100644
meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch<br>
                          <br>
                          -- <br>
                          2.7.4<br>
                          <br>
                          -- <br>
_______________________________________________<br>
                          bitbake-devel mailing list<br>
                          <a
                            href="mailto:bitbake-devel@lists.openembedded.org"
                            target="_blank" moz-do-not-send="true">bitbake-devel@lists.openembedded.org</a><br>
                          <a
                            href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
                        </blockquote>
                      </div>
                      <br>
                      <fieldset
class="gmail-m_-6627059004469126089gmail-m_7305473577171404396mimeAttachmentHeader"></fieldset>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------D355659DE16E08B35F0BD136--
