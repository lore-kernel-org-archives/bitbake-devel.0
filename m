Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id 6A7636067C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:58:22 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id f6so6425249ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=iq8+L7mQOFop/GWZomzn/Dj//rmAjhc2XVUvY2+N25Y=;
	b=Sa5Yxb13VREmv1MXWI8L/2UYUWsTVsWbCTswCUcWemEeFjbf2O8oqNkzMjI2Hzv3Ha
	ABdtxsAwU/6YAsCFtbbbhkub2dkqfSydXnUoU90Gx9es9hb00v0a4h4wswoabNnPai3M
	svfoXlAdC+3LMDLnNX8cr1D6swqXz4SwodP7379AA3Zfi35XHgRBdK89pMHMX8+iXREr
	9k/SmvuZpobnQ9+Ovtc9tKasn3PysJ2pS3wXlsEXV9v7ml1k0+WxTFxJFsZhoVSKAeuC
	E3n5tYmHJiwFpzNXmZc5nhubi9bEa+tH9kGVi7O2zKpkJOsdRjadUcFX0SunHZtiOA7a
	wviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=iq8+L7mQOFop/GWZomzn/Dj//rmAjhc2XVUvY2+N25Y=;
	b=YxH7XQT7kPdaW0hCCuQt0IPlaDDlkz1NU1eVOyGf7rERyNChP2kEK/6kVsj9cm3Dxb
	gsGoD/a+dZoK2eGOop/I9eSlfUd4doUIHiXEuKg63hO97EcrZ45sgExO6o2pxyQ60egI
	/g9XSwo+tIYIJKaLrZpBpzi2aRGFUKO9t8BMKmfwMht1k8ZJzkroGf0bs5d4YcvwHyzJ
	uy67IpcOnTGVhRlU+SOuQ0QdzkEmZLiTJRucyjFEmLbrid/2/Q1Ie3M0iky21keHC/Vc
	nFG92qU5nKO29Xc00M0e9quv+H9aPh5j2OkTZRp/4UGoQJCWgmGPwPovnIdVVqdXpCIQ
	WcGQ==
X-Gm-Message-State: ALyK8tIL3bW12TBh29lUbZEiqf8VOoOrfqhwJ6wUQIoPRhAnyHEh/jeTdkpURkD9pQrASWU1nI6hd5ZH4iThLg==
X-Received: by 10.36.216.5 with SMTP id b5mr5772440itg.19.1468364303272; Tue,
	12 Jul 2016 15:58:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.21.197 with HTTP; Tue, 12 Jul 2016 15:58:03 -0700 (PDT)
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
	<4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 12 Jul 2016 15:58:03 -0700
X-Google-Sender-Auth: wDLQ_Xt5Pf9R2N14-KwuS8uysfI
Message-ID: <CABcZANnVeckXjiT5eueAucA5LBtPYsH0d7xuv4QFjgkoFM+fAQ@mail.gmail.com>
To: bavery <brian.avery@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 01/17] runqueue: improve exception logging
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
X-List-Received-Date: Tue, 12 Jul 2016 22:58:23 -0000
Content-Type: multipart/alternative; boundary=94eb2c05cc14b2931f05377834da

--94eb2c05cc14b2931f05377834da
Content-Type: text/plain; charset=UTF-8

On Tue, Jul 12, 2016 at 3:54 PM, bavery <brian.avery@intel.com> wrote:

> -            logger.error("An uncaught exception occured in runqueue,
> please see the failure below:")
> +        except Exception as err:
> +            logger.exception("An uncaught exception occured in runqueue")
>

Should probably fix the typo while we're here. 'occured' isn't spelled
correctly, 'occurred' is.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c05cc14b2931f05377834da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jul 12, 2016 at 3:54 PM, bavery <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:brian.avery@intel.com" target=3D"_blank">brian.avery@intel.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":wb" class=3D"a=
3s aXjCH m155e15122d302a37">-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logg=
er.error(&quot;An uncaught exception occured in runqueue, please see the fa=
ilure below:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.exception(&quot;An uncaug=
ht exception occured in runqueue&quot;)</div></blockquote></div><br>Should =
probably fix the typo while we&#39;re here. &#39;occured&#39; isn&#39;t spe=
lled correctly, &#39;occurred&#39; is.<br>-- <br><div class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature">Christopher Larson<br>clarson at ke=
rgoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer =
- Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c05cc14b2931f05377834da--
