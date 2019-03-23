Return-Path: <akuster@mvista.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id DDF8B6067C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 14:41:52 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id y3so3438967pgk.12
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=/usAagnWBXzVBatLTYbIsUwKaCS98ZKNzKVG8qbx6Zc=;
	b=DXdSDIdDfyJ4/wS9gYXMXVmTVLhxGoa/2i9s58lOBoMoiZ2Dr9D7kHP8yzKaO9/hHT
	jQ+CXWUMnVMCF8C+RX4QfDqC4s4MRxeevBNELDPbTAX7miGmXXcQoCma2UFshqx397Ob
	jZT14scSTAhnyA9t1VpgUP2AvMiZF94MwX5+rbSwLktj+rpcZLgIh6f+1Kbhquxs5GF0
	R/1JHvVLzMdGN0chntJYVtEYxC8ZEc6nHumlI3ywO/YNeg9Z6kV8GfhITQ+gmXGAH7Ze
	l7HVbOZU1jVrSVmWiPnxPLwxKpIFBKZWC7jeeSE6OW+lStLfhrJIyv4YcVCUjAvj+FKw
	4Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language;
	bh=/usAagnWBXzVBatLTYbIsUwKaCS98ZKNzKVG8qbx6Zc=;
	b=LWtt3fUXtxMGZGBrONWJFVGta63tPhwERQf9xfYraM3SUN3wLI/bJSm/XwIR9mgvsc
	j8rzAenoXc1jeFa68D1GTr4/G8fQhmyjYsYSg9ElB7Qd2nYaWID2fkFR5N7gcVz6wP60
	sRUDP11jpmhCw6tDacY34/w/G1fKbD0Hg7TPvcgffiv79Me061Q8YgYqB0PiHC+gIdiq
	kMXqnuNVXXfttENaAvH3om/xrUxTqBKdbn9o9PYcj91TDoAkjfItSWU8eEcsx43O9iNk
	MSP75qLFJq0PEEvXTTSSEJ6815BX+GnIjgtrBicPnz3E6yfgAMuVaNyuaI3y8oiqorSM
	MASg==
X-Gm-Message-State: APjAAAVUynOeZewKBQc0VgVIOk41dM90fN1JBd2k83BLx2DibCC+Ucno
	PVKBIanQ42yuP+XM3Ezia4s4zgTTSVc=
X-Google-Smtp-Source: APXvYqwTNxH8iCVBJqr4xkZnuxOoHD1OiSXZ4jLKm/9WGbwrjXWOEVW+l8kBsPnNpuKv9ax6Fn4C1A==
X-Received: by 2002:a65:6289:: with SMTP id f9mr1193096pgv.380.1553352113483; 
	Sat, 23 Mar 2019 07:41:53 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:9ce3:bbbb:72cd:d5f9?
	([2601:202:4180:c33:9ce3:bbbb:72cd:d5f9])
	by smtp.gmail.com with ESMTPSA id
	j17sm8379141pfa.51.2019.03.23.07.41.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Mar 2019 07:41:52 -0700 (PDT)
To: Martin Jansa <martin.jansa@gmail.com>, Armin Kuster <akuster808@gmail.com>
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
	<CA+chaQcS7kh10qhcJ-XBL=qO7Gj=rj4rovZS1tM5wQ3BARPrWg@mail.gmail.com>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <bf3c23e1-ade1-98fa-82c4-c372caf8b7f6@mvista.com>
Date: Sat, 23 Mar 2019 07:41:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+chaQcS7kh10qhcJ-XBL=qO7Gj=rj4rovZS1tM5wQ3BARPrWg@mail.gmail.com>
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
X-List-Received-Date: Sat, 23 Mar 2019 14:41:53 -0000
Content-Type: multipart/alternative;
	boundary="------------3D6827F7406A5B6F6147C010"
Content-Language: en-US

--------------3D6827F7406A5B6F6147C010
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 3/23/19 1:33 AM, Martin Jansa wrote:
> Nor in:
> http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next

This is for core. I sent the pull request to the wrong list.

The bitbake changes should be in :
https://git.openembedded.org/bitbake-contrib/log/?h=stable/1.40-next

- armin
>
> On Sat, Mar 23, 2019 at 9:32 AM Martin Jansa <martin.jansa@gmail.com
> <mailto:martin.jansa@gmail.com>> wrote:
>
>     Hi,
>
>     is there a reason for not including
>     https://patchwork.openembedded.org/patch/159465/
>     ?
>
>     It says sumo-next on patchwork, but I don't know which sumo-next
>     it is, I don't see it in:
>     http://git.openembedded.org/openembedded-core/log/?h=sumo-next
>
>     On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster <akuster808@gmail.com
>     <mailto:akuster808@gmail.com>> wrote:
>
>         Please consider this for the next sumo update
>
>         The following changes since commit
>         6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>
>           package_rpm/archiver: Apply bandaid to src.rpm creation
>         (2019-02-25 22:13:08 +0000)
>
>         are available in the git repository at:
>
>           git://git.openembedded.org/openembedded-core-contrib
>         <http://git.openembedded.org/openembedded-core-contrib>
>         stable/sumo-next
>          
>         http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>
>         Chen Qi (2):
>           systemd: fix CVE-2018-15686
>           systemd: fix CVE-2018-15688
>
>         George McCollister (5):
>           systemd: fix CVE-2018-15687
>           systemd: Security fix CVE-2018-16864
>           systemd: Security fix CVE-2018-16865
>           systemd: fix CVE-2018-6954
>           systemd: fix CVE-2019-6454
>
>         Marcus Cooper (1):
>           systemd: Security fix CVE-2018-16866
>
>         Mingli Yu (1):
>           logrotate.py: restore /etc/logrotate.d/wtmp
>
>         ROGEZ Matthieu (1):
>           systemd: Fix typo in root home variable.
>
>         Richard Purdie (1):
>           oeqa/runtime/dnf: Fix test error when static libs are enabled
>
>         Stefan Agner (1):
>           run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>
>          meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>          meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>          ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>          ...eserializing-state-always-use-read_line-L.patch |  250 +++
>          ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>          ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>          .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
>         ++++++++++++++++++++
>          ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>          ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>          ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>          ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>          .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>          ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>          meta/recipes-core/systemd/systemd_237.bb
>         <http://systemd_237.bb>           |   13 +-
>          .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>          .../run-postinsts/run-postinsts.service            |    1 -
>          16 files changed, 3694 insertions(+), 13 deletions(-)
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>          create mode 100644
>         meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>
>         -- 
>         2.7.4
>
>         -- 
>         _______________________________________________
>         bitbake-devel mailing list
>         bitbake-devel@lists.openembedded.org
>         <mailto:bitbake-devel@lists.openembedded.org>
>         http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>


--------------3D6827F7406A5B6F6147C010
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/23/19 1:33 AM, Martin Jansa wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQcS7kh10qhcJ-XBL=qO7Gj=rj4rovZS1tM5wQ3BARPrWg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Nor in:
        <div><a
href="http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
            moz-do-not-send="true">http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
        </div>
      </div>
    </blockquote>
    <br>
    This is for core. I sent the pull request to the wrong list. <br>
    <br>
    The bitbake changes should be in :
    <a class="moz-txt-link-freetext" href="https://git.openembedded.org/bitbake-contrib/log/?h=stable/1.40-next">https://git.openembedded.org/bitbake-contrib/log/?h=stable/1.40-next</a><br>
    <br>
    - armin<br>
    <blockquote type="cite"
cite="mid:CA+chaQcS7kh10qhcJ-XBL=qO7Gj=rj4rovZS1tM5wQ3BARPrWg@mail.gmail.com"><br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019 at 9:32
          AM Martin Jansa &lt;<a href="mailto:martin.jansa@gmail.com"
            moz-do-not-send="true">martin.jansa@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
            <div>It says sumo-next on patchwork, but I don't know which
              sumo-next it is, I don't see it in:</div>
            <div><a
                href="http://git.openembedded.org/openembedded-core/log/?h=sumo-next"
                target="_blank" moz-do-not-send="true">http://git.openembedded.org/openembedded-core/log/?h=sumo-next</a><br>
            </div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Sat, Mar 23, 2019 at
              3:12 AM Armin Kuster &lt;<a
                href="mailto:akuster808@gmail.com" target="_blank"
                moz-do-not-send="true">akuster808@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">Please consider this
              for the next sumo update<br>
              <br>
              The following changes since commit
              6d56e912fbbaa22830b4da5ab230586a3d15b23e:<br>
              <br>
                package_rpm/archiver: Apply bandaid to src.rpm creation
              (2019-02-25 22:13:08 +0000)<br>
              <br>
              are available in the git repository at:<br>
              <br>
                git://<a
                href="http://git.openembedded.org/openembedded-core-contrib"
                rel="noreferrer" target="_blank" moz-do-not-send="true">git.openembedded.org/openembedded-core-contrib</a>
              stable/sumo-next<br>
                <a
href="http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next"
                rel="noreferrer" target="_blank" moz-do-not-send="true">http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next</a><br>
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
                oeqa/runtime/dnf: Fix test error when static libs are
              enabled<br>
              <br>
              Stefan Agner (1):<br>
                run-postinsts: for dpkg/opkg, do not rely on
              /etc/*-postinsts<br>
              <br>
               meta/lib/oeqa/runtime/cases/dnf.py                 |    2
              +-<br>
               meta/lib/oeqa/runtime/cases/logrotate.py           |    6
              +-<br>
               ...sive-let-s-rework-the-recursive-logic-to-.patch |  252
              +++<br>
               ...eserializing-state-always-use-read_line-L.patch |  250
              +++<br>
               ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39
              +<br>
               ...n-t-resolve-pathnames-when-traversing-rec.patch |  643
              +++++++<br>
               .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
              ++++++++++++++++++++<br>
               ...-not-store-the-iovec-entry-for-process-co.patch |  193
              +++<br>
               ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60
              +<br>
               ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79
              +<br>
               ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49
              +<br>
               .../systemd/systemd/CVE-2019-6454.patch            |  210
              +++<br>
               ...e-receive-an-invalid-dbus-message-ignore-.patch |   61
              +<br>
               meta/recipes-core/systemd/<a href="http://systemd_237.bb"
                rel="noreferrer" target="_blank" moz-do-not-send="true">systemd_237.bb</a> 
                       |   13 +-<br>
               .../run-postinsts/run-postinsts/run-postinsts      |   21
              +-<br>
               .../run-postinsts/run-postinsts.service            |    1
              -<br>
               16 files changed, 3694 insertions(+), 13 deletions(-)<br>
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
              <a href="mailto:bitbake-devel@lists.openembedded.org"
                target="_blank" moz-do-not-send="true">bitbake-devel@lists.openembedded.org</a><br>
              <a
                href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                rel="noreferrer" target="_blank" moz-do-not-send="true">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
            </blockquote>
          </div>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
    </blockquote>
    <br>
  </body>
</html>

--------------3D6827F7406A5B6F6147C010--
