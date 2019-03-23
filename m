Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id BB8897C617
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 08:33:25 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id p1so4682789wrs.8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U641wcz27jv1GOQOOyO4PujvpUzu6MUC/d7g6elp9vE=;
	b=oUxVu8/91/wBTssl6xE8ot8YUHPP1ans0M3SCr/AvzvxZDUUbIjqGNCc2BU9jDBQ/q
	QAh6n7dwOHMvXWx/d6cSHeBgw1kenv8luT5ww/rMxCw3UbNDLVmpKowdD1VDOgQ+EOL4
	Ho4mbwk2qvHTPZPXMAjqI5iEIYiLlW8n0jTvmgIsAmd1e2KHFS/2i95oi/YHTTWVE/7D
	gZ7mmKdiDmoyRo41E4gsG2b5JF2TSRV/8DdeaDI6DGuLR4Z4IXZzggdFMw+iHXQ2o0WO
	5ddBkG4oe+4HeYGrTp3bn9am7G7PAI2vQLxOH1RK6j7naeTeLTvtssFxDwzx3uXRZAV+
	0NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U641wcz27jv1GOQOOyO4PujvpUzu6MUC/d7g6elp9vE=;
	b=WzJMYvW2cabZk58YAdqJJi7OLnPn37ZFPOX+gWCKSj+3PdXO6eedTnFe5jWYxhAi2H
	sqBPZK3dXvZTeVrbaqlUDBOrXhua3XBfipqbV8+kqU5oK2TEdUCZHL/NV3b5egEArOLm
	00arwJQE/3ooRPTXv7jL+JKj/3WzGNOIR5j4KYjPRw9OxflDbgotzlqlWIBM2NaQ4eb6
	Mcbh2Ckbvr5h4LBqGRSB5s//9qph14qt1SlxQ/4BBUEWn5aij1Ge3gpFVxNdBOFU8Htu
	Ew4eJkWLKj0qBEkRhrJeeeP1KAi/K0Gygkmp4WbYJ5hALH9EVICXiAwRdl7EOQ/IV/pG
	0DeA==
X-Gm-Message-State: APjAAAUj1iXW4g8gbnbqmiyhGTQH9Nd9j1oecdKaHI3ejyBKxrllveYN
	ll9trtVxDpipXNqGCK2Cut82PXci1LHe9ovguU47prfQ
X-Google-Smtp-Source: APXvYqwixAZe2gCRS2FlZd+CFnJwzEo3zZDgwxgVeraHzhKcXEtyPFQxSL9nOQs4Jr5lQxlCKuD4PF4LlgKBJU95MMY=
X-Received: by 2002:a5d:4606:: with SMTP id t6mr9001572wrq.43.1553330006526;
	Sat, 23 Mar 2019 01:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
In-Reply-To: <CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 23 Mar 2019 09:33:15 +0100
Message-ID: <CA+chaQcS7kh10qhcJ-XBL=qO7Gj=rj4rovZS1tM5wQ3BARPrWg@mail.gmail.com>
To: Armin Kuster <akuster808@gmail.com>
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
X-List-Received-Date: Sat, 23 Mar 2019 08:33:25 -0000
Content-Type: multipart/alternative; boundary="000000000000420f8a0584bed3ca"

--000000000000420f8a0584bed3ca
Content-Type: text/plain; charset="UTF-8"

Nor in:
http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next

On Sat, Mar 23, 2019 at 9:32 AM Martin Jansa <martin.jansa@gmail.com> wrote:

> Hi,
>
> is there a reason for not including
> https://patchwork.openembedded.org/patch/159465/
> ?
>
> It says sumo-next on patchwork, but I don't know which sumo-next it is, I
> don't see it in:
> http://git.openembedded.org/openembedded-core/log/?h=sumo-next
>
> On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster <akuster808@gmail.com> wrote:
>
>> Please consider this for the next sumo update
>>
>> The following changes since commit
>> 6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>>
>>   package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25
>> 22:13:08 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
>>
>> http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>>
>> Chen Qi (2):
>>   systemd: fix CVE-2018-15686
>>   systemd: fix CVE-2018-15688
>>
>> George McCollister (5):
>>   systemd: fix CVE-2018-15687
>>   systemd: Security fix CVE-2018-16864
>>   systemd: Security fix CVE-2018-16865
>>   systemd: fix CVE-2018-6954
>>   systemd: fix CVE-2019-6454
>>
>> Marcus Cooper (1):
>>   systemd: Security fix CVE-2018-16866
>>
>> Mingli Yu (1):
>>   logrotate.py: restore /etc/logrotate.d/wtmp
>>
>> ROGEZ Matthieu (1):
>>   systemd: Fix typo in root home variable.
>>
>> Richard Purdie (1):
>>   oeqa/runtime/dnf: Fix test error when static libs are enabled
>>
>> Stefan Agner (1):
>>   run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>>
>>  meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>>  meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>>  ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>>  ...eserializing-state-always-use-read_line-L.patch |  250 +++
>>  ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>>  ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>>  .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
>> ++++++++++++++++++++
>>  ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>>  ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>>  ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>>  ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>>  .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>>  ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>>  meta/recipes-core/systemd/systemd_237.bb           |   13 +-
>>  .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>>  .../run-postinsts/run-postinsts.service            |    1 -
>>  16 files changed, 3694 insertions(+), 13 deletions(-)
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>>  create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>>
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>

--000000000000420f8a0584bed3ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Nor in:<div><a href=3D"http://git.openembedded.org/openemb=
edded-core-contrib/log/?h=3Dstable/sumo-next">http://git.openembedded.org/o=
penembedded-core-contrib/log/?h=3Dstable/sumo-next</a><br></div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar=
 23, 2019 at 9:32 AM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.=
com">martin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>is there=
 a reason for not including</div><div><a href=3D"https://patchwork.openembe=
dded.org/patch/159465/" target=3D"_blank">https://patchwork.openembedded.or=
g/patch/159465/</a><br></div><div>?</div><div><br></div><div>It says sumo-n=
ext on patchwork, but I don&#39;t know which sumo-next it is, I don&#39;t s=
ee it in:</div><div><a href=3D"http://git.openembedded.org/openembedded-cor=
e/log/?h=3Dsumo-next" target=3D"_blank">http://git.openembedded.org/openemb=
edded-core/log/?h=3Dsumo-next</a><br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019 at 3:12 AM =
Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com" target=3D"_blank">=
akuster808@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Please consider this for the next sumo update<br>
<br>
The following changes since commit 6d56e912fbbaa22830b4da5ab230586a3d15b23e=
:<br>
<br>
=C2=A0 package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25 =
22:13:08 +0000)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.openembedded.org/openembedded-core-contr=
ib" rel=3D"noreferrer" target=3D"_blank">git.openembedded.org/openembedded-=
core-contrib</a> stable/sumo-next<br>
=C2=A0 <a href=3D"http://cgit.openembedded.org/openembedded-core-contrib/lo=
g/?h=3Dstable/sumo-next" rel=3D"noreferrer" target=3D"_blank">http://cgit.o=
penembedded.org/openembedded-core-contrib/log/?h=3Dstable/sumo-next</a><br>
<br>
Chen Qi (2):<br>
=C2=A0 systemd: fix CVE-2018-15686<br>
=C2=A0 systemd: fix CVE-2018-15688<br>
<br>
George McCollister (5):<br>
=C2=A0 systemd: fix CVE-2018-15687<br>
=C2=A0 systemd: Security fix CVE-2018-16864<br>
=C2=A0 systemd: Security fix CVE-2018-16865<br>
=C2=A0 systemd: fix CVE-2018-6954<br>
=C2=A0 systemd: fix CVE-2019-6454<br>
<br>
Marcus Cooper (1):<br>
=C2=A0 systemd: Security fix CVE-2018-16866<br>
<br>
Mingli Yu (1):<br>
=C2=A0 logrotate.py: restore /etc/logrotate.d/wtmp<br>
<br>
ROGEZ Matthieu (1):<br>
=C2=A0 systemd: Fix typo in root home variable.<br>
<br>
Richard Purdie (1):<br>
=C2=A0 oeqa/runtime/dnf: Fix test error when static libs are enabled<br>
<br>
Stefan Agner (1):<br>
=C2=A0 run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts<br>
<br>
=C2=A0meta/lib/oeqa/runtime/cases/dnf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
=C2=A0meta/lib/oeqa/runtime/cases/logrotate.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-<br>
=C2=A0...sive-let-s-rework-the-recursive-logic-to-.patch |=C2=A0 252 +++<br=
>
=C2=A0...eserializing-state-always-use-read_line-L.patch |=C2=A0 250 +++<br=
>
=C2=A0...sure-we-have-enough-space-for-the-DHCP6-o.patch |=C2=A0 =C2=A039 +=
<br>
=C2=A0...n-t-resolve-pathnames-when-traversing-rec.patch |=C2=A0 643 ++++++=
+<br>
=C2=A0.../systemd/systemd/0002-Make-tmpfiles-safe.patch=C2=A0 | 1828 ++++++=
++++++++++++++<br>
=C2=A0...-not-store-the-iovec-entry-for-process-co.patch |=C2=A0 193 +++<br=
>
=C2=A0...ld-set-a-limit-on-the-number-of-fields-1k.patch |=C2=A0 =C2=A060 +=
<br>
=C2=A0...ote-set-a-limit-on-the-number-of-fields-i.patch |=C2=A0 =C2=A079 +=
<br>
=C2=A0...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |=C2=A0 =C2=A049 +=
<br>
=C2=A0.../systemd/systemd/CVE-2019-6454.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 210 +++<br>
=C2=A0...e-receive-an-invalid-dbus-message-ignore-.patch |=C2=A0 =C2=A061 +=
<br>
=C2=A0meta/recipes-core/systemd/<a href=3D"http://systemd_237.bb" rel=3D"no=
referrer" target=3D"_blank">systemd_237.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A013 +-<br>
=C2=A0.../run-postinsts/run-postinsts/run-postinsts=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A021 +-<br>
=C2=A0.../run-postinsts/run-postinsts.service=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<br>
=C2=A016 files changed, 3694 insertions(+), 13 deletions(-)<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0001-chown-recur=
sive-let-s-rework-the-recursive-logic-to-.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0001-core-when-d=
eserializing-state-always-use-read_line-L.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0001-dhcp6-make-=
sure-we-have-enough-space-for-the-DHCP6-o.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0001-tmpfiles-do=
n-t-resolve-pathnames-when-traversing-rec.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0002-Make-tmpfil=
es-safe.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0024-journald-do=
-not-store-the-iovec-entry-for-process-co.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0025-journald-se=
t-a-limit-on-the-number-of-fields-1k.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0026-journal-rem=
ote-set-a-limit-on-the-number-of-fields-i.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/0027-journal-fix=
-out-of-bounds-read-CVE-2018-16866.patch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.pa=
tch<br>
=C2=A0create mode 100644 meta/recipes-core/systemd/systemd/sd-bus-if-we-rec=
eive-an-invalid-dbus-message-ignore-.patch<br>
<br>
-- <br>
2.7.4<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>
</blockquote></div>

--000000000000420f8a0584bed3ca--
