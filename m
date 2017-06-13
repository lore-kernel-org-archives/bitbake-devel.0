Return-Path: <kergoth@gmail.com>
Received: from mail-ot0-f180.google.com (mail-ot0-f180.google.com
	[74.125.82.180])
	by mail.openembedded.org (Postfix) with ESMTP id 1E185782FC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jun 2017 15:46:35 +0000 (UTC)
Received: by mail-ot0-f180.google.com with SMTP id t31so90965408ota.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jun 2017 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=qSpfHpQ167Wv55yfsebX04248MQGYOPbZ9DkJQK6UFY=;
	b=BY+G3LrpEpt7E/e5YCHJEimYfK6a0MbXY2rS1PiKvj2RQQOq3Eiasymn7Pq2exBv2I
	ePXgxyAXoCBaUP/qMUmtOwsah+7yMj67zyKOQWihLNX5jNFwLy1C2kJX6oBm+i1JCPMF
	IKcmGjvyKF6tpyV2PfhmiYMntMRuZrPZfwNzvNWNyyVTmjwrj/D9FbhsCkXCckdl0Ah/
	KBMJprgbT7EtYE2KkHcIw5nuPnToxi5IDBZNbSU1kK+Pn1suvyPy7jQTw/ofp0kUutYP
	NQ3ry6Tto2RW1PpCWXdZadTw3lhxBb0J5xbASXhdRZIjNGDTeWFJT0IRED681/FriRJt
	2pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=qSpfHpQ167Wv55yfsebX04248MQGYOPbZ9DkJQK6UFY=;
	b=fHjBD3MfYfF+8sjYlfgaMueAkY3BZdSmMKHOh1NYcmRA2N7YJbTQh9zYu/AJ8BRBLP
	e4tGlJ4Pd2tb5FPSvoBLbKV2Zk/76w01WOr2ZK7rtRPcwu4suZUA8MKLq7w65B6OBy/g
	54wYuqY5rxz7x75Ght7hVUaEER9WGu0d9RTMfsykzVy0ur2o8ImOSbetx7SA7oZRJoGq
	KKMQPNGb8flRYYb+4UlTD1gVeu0gIV7tpKSLWFNnLbvSUCTku3Jjz/1mSUlMc/QItgkP
	iWmbPfX8sB4tdkFwJ8k1LuJESmMcgS5mzeSYk9msEEcvFS7dMG0t2xtEoTde/4lwjAmZ
	Ag9Q==
X-Gm-Message-State: AKS2vOxWMKMmjUZllNbUK9Tfagq5ZPCoKWKMEzs8Qi5FHXs/UoORzZA6
	EKJhTS3uK8Cir9GfBNi2Db0d54VLbg==
X-Received: by 10.157.4.239 with SMTP id 102mr368540otm.65.1497368796797; Tue,
	13 Jun 2017 08:46:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.230 with HTTP; Tue, 13 Jun 2017 08:46:16 -0700 (PDT)
In-Reply-To: <1497287524-5406-2-git-send-email-juro.bystricky@intel.com>
References: <1497287524-5406-1-git-send-email-juro.bystricky@intel.com>
	<1497287524-5406-2-git-send-email-juro.bystricky@intel.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 13 Jun 2017 08:46:16 -0700
Message-ID: <CABcZANnXvtwQB499_GZGb1R7TEPiezuHhQLdb+Yfyn+od4eehA@mail.gmail.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: "Purdie, Richard" <richard.purdie@intel.com>,
	Juro Bystricky <jurobystricky@hotmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"paul.eggleton@linux.intel.com" <paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] bitbake:process: flush stderr/stdout to log
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
X-List-Received-Date: Tue, 13 Jun 2017 15:46:36 -0000
Content-Type: multipart/alternative; boundary="94eb2c09deea3b21020551d957d4"

--94eb2c09deea3b21020551d957d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 10:12 AM, Juro Bystricky <juro.bystricky@intel.com>
wrote:

> -    finally:
> -        log.flush()
> -
> -    readextras([fobj for fobj, _ in extrafiles])
> +            read_all_pipes(log, rin, outdata, errdata)
> +
> +        # Pocess closed, drain all pipes...
> +        read_all_pipes(log, rin, outdata, errdata)
> +    finally:
> +        log.flush
>

You forgot a (), so you aren=E2=80=99t actually running flush here.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--94eb2c09deea3b21020551d957d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jun 12, 2017 at 10:12 AM, Juro Bystricky <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.bystricky@in=
tel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"=
:25s" class=3D"a3s aXjCH m15c9d4ad91752e18">-=C2=A0 =C2=A0 finally:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 log.flush()<br>
-<br>
-=C2=A0 =C2=A0 readextras([fobj for fobj, _ in extrafiles])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read_all_pipes(log, rin, outdata=
, errdata)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Pocess closed, drain all pipes...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_all_pipes(log, rin, outdata, errdata)<br>
+=C2=A0 =C2=A0 finally:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log.flush</div></blockquote></div><br>You forg=
ot a (), so you aren=E2=80=99t actually running flush here.<br>-- <br><div =
class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"lt=
r"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>=
Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Me=
ntor Graphics</div></div></div></div>
</div></div>

--94eb2c09deea3b21020551d957d4--
