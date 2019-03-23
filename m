Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 3331D7C617
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 08:32:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id t5so4691389wri.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+sTk5zsUTKhyhZI1wt3yOSmSfFZf41KoMKikdbEnK7w=;
	b=ASAcwGNI7qSnwkgTp27HaFG2nANmnnhUT93j5mkZq2Mre2SsSTQygJCKJVMGUGK0MB
	Sfoik5Tsy+tN7xGCCsmnSAcKoz7oM+8u9BElkuPF7TxD33XuQP38Rf4zhnZqTY2B6Coz
	1apMM98MZBXE0yX4de+j2cmOLgNYhupNtWOFVblCMy6U3hj4wELD355+iwIGnK4TomRL
	7e7IQjjfPaWOlGQwCHTfMeG7oL9k8SxuxjeRRf+buQbGcWF/xAZIEZ3FmJEK/Dxf9ale
	sDan86SHCX3MWLnDBoycFRjC8n8UrkPyjjcnAldSepllXkkA0jd0e5WDqHJug4W/7tAC
	6gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+sTk5zsUTKhyhZI1wt3yOSmSfFZf41KoMKikdbEnK7w=;
	b=r9rpQtnvt6POZGKzLXGcsaCiOynq68XiHhqUnN8voZKX9qvRsP25r32jiY21yLlpwB
	Vcg3bcGp4aYC66kXfSwbHtuxuK4V88bONH/o8v8tVpy6/n5tnihBjRzuEjZ2mfvcnJNM
	0k0ij1UhwWWrvoZQB9ngU0lsHD4FkEeOwNd+kDlW6Ni/TpoXy2BMJcMlu1I9D7NGjo+A
	nsreI+QIoxOd/RT5SgqCNWNfMXh2nJS+mEgacdaD9ocnATcvxKH+2K4N1VUWr2y1QwGj
	0CPvrgatKLgx5YxeeXqtgYuijPM5zgqKLU7RFyNUu/mBidTr+r+6o1xhFzmhDbuw3XG3
	eqVQ==
X-Gm-Message-State: APjAAAVzcuY7TrLdvAbErpWZVP+6Qn1iZuIeTxb3m5iU7sLONvvErCBL
	Vzo32mBJqczS1dHtZJgJCLHSrUpZFluK8b+d6bM=
X-Google-Smtp-Source: APXvYqxzaN0xm30cOrKmu/anQEn370oTwh5M1wyO3nyat7EgBEpK/CTwcWrr0odLC27t9CxWUyEHwy6m9wYh6lvLoJM=
X-Received: by 2002:adf:f846:: with SMTP id d6mr1163951wrq.53.1553329940900;
	Sat, 23 Mar 2019 01:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553306877.git.akuster808@gmail.com>
In-Reply-To: <cover.1553306877.git.akuster808@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 23 Mar 2019 09:32:09 +0100
Message-ID: <CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
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
X-List-Received-Date: Sat, 23 Mar 2019 08:32:20 -0000
Content-Type: multipart/alternative; boundary="00000000000058af1b0584becf44"

--00000000000058af1b0584becf44
Content-Type: text/plain; charset="UTF-8"

Hi,

is there a reason for not including
https://patchwork.openembedded.org/patch/159465/
?

It says sumo-next on patchwork, but I don't know which sumo-next it is, I
don't see it in:
http://git.openembedded.org/openembedded-core/log/?h=sumo-next

On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster <akuster808@gmail.com> wrote:

> Please consider this for the next sumo update
>
> The following changes since commit
> 6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>
>   package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25
> 22:13:08 +0000)
>
> are available in the git repository at:
>
>   git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
>
> http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>
> Chen Qi (2):
>   systemd: fix CVE-2018-15686
>   systemd: fix CVE-2018-15688
>
> George McCollister (5):
>   systemd: fix CVE-2018-15687
>   systemd: Security fix CVE-2018-16864
>   systemd: Security fix CVE-2018-16865
>   systemd: fix CVE-2018-6954
>   systemd: fix CVE-2019-6454
>
> Marcus Cooper (1):
>   systemd: Security fix CVE-2018-16866
>
> Mingli Yu (1):
>   logrotate.py: restore /etc/logrotate.d/wtmp
>
> ROGEZ Matthieu (1):
>   systemd: Fix typo in root home variable.
>
> Richard Purdie (1):
>   oeqa/runtime/dnf: Fix test error when static libs are enabled
>
> Stefan Agner (1):
>   run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>
>  meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>  meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>  ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>  ...eserializing-state-always-use-read_line-L.patch |  250 +++
>  ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>  ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>  .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
> ++++++++++++++++++++
>  ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>  ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>  ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>  ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>  .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>  ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>  meta/recipes-core/systemd/systemd_237.bb           |   13 +-
>  .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>  .../run-postinsts/run-postinsts.service            |    1 -
>  16 files changed, 3694 insertions(+), 13 deletions(-)
>  create mode 100644
> meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>  create mode 100644
> meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000058af1b0584becf44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>is there a reason for not including=
</div><div><a href=3D"https://patchwork.openembedded.org/patch/159465/">htt=
ps://patchwork.openembedded.org/patch/159465/</a><br></div><div>?</div><div=
><br></div><div>It says sumo-next on patchwork, but I don&#39;t know which =
sumo-next it is, I don&#39;t see it in:</div><div><a href=3D"http://git.ope=
nembedded.org/openembedded-core/log/?h=3Dsumo-next">http://git.openembedded=
.org/openembedded-core/log/?h=3Dsumo-next</a><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019=
 at 3:12 AM Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com">akuste=
r808@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Please consider this for the next sumo update<br>
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

--00000000000058af1b0584becf44--
