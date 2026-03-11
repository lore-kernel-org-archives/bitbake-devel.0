Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D33103E2F5
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 23:26:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9934.1773271599059407048
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Mar 2026 16:26:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IqbkSXtr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b94a19fdso389914f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773271597; x=1773876397; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYKKhJbDIjI+vgLarZQvoeU4k/efsIVxj/7khy+b3hg=;
        b=IqbkSXtr32PU2/t7KbJ6xyeq0AKZtNUp6VUyNrEpBHN8G2oy3IPmTYq3ivUv+R283Y
         /YhJ/TZy1oJtQwU73o3HIGKd1JyVRr+CSKBWkzM9vi/W3jTyK0fuuplrRvJA9788P0Sk
         dQ+6NXr6ud9Y9SYljddsX8MTpi7ZBhBiI1CDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271597; x=1773876397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYKKhJbDIjI+vgLarZQvoeU4k/efsIVxj/7khy+b3hg=;
        b=I6HH+RvUMH7m3PMOzQytz7GrvATY9IHbAmFVtyBwkgQGEmvmUw10YpSsiB4dH9VAqs
         4jPAJhqzgAcifTvIlo7iTAo5j25f/EeqK0aLimgRgoa5hBQSQgzGimuw0QyNPk0mlFfD
         +Doxob9cJCMyWxzj5sEaMZuIYlu43BKI7N4l/ZWd0npbcQZejfG/0xl8d45Epjk0x8w7
         H7W4tVy3NuPyfLwEKmrPwN3hQUq3+JX/4pEXdCCvOLVPoBQ0WllGsV04KoGutkUE/SLB
         rxqIACBKdqRGzwElAGmiqXO6Ovvteg2M6MIbzbQV+EKSwgWpsOzysOMo5XgvpQU9/dsW
         xNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw3+9+lKYcclXTOIAJlgch7rj5rVJ3Ro0gTS71qHQ3zR+tNYKaaPVSXq+BxxeDNtf06SdilIT99eFhep0D@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy8MYTqXc1TCVZ947SF9+b3MGskoxRAHDxK6mM4uvZC1nvpQ4C1
	i1/iKTynuSqJYmdwUid/W4jebzlJCRNlpbdFGtkwxvVcoZcQ12bZHulG16/9CzGm+0s=
X-Gm-Gg: ATEYQzyx58yvo/7d5d8D4WdN11LN2Yp0o5tltB0w+qNVuAbNt+gSipJKHhZQlG06Vwd
	cwbNsois6TGphY0cDCaeWkq3bSHpsdSPL6YDYxdy5wDFyeGKJ7qkcrLJ7cAA4m9Oece3xgPylEb
	/GWujJ8WUBdB6VGy6Fmy5VvGS7PH21qQADgCqCOOASdpXt8SbItby88PXtcddJnA+DnNDFVg2ng
	t8NLvJLt6a7wkwG9SS9pxj9rR6dlzjhTSB1XF4QLte3js2ZcPJsTaINqsd0TO7n+a7Fnm/sHKyn
	73a3d3bjLcrpL6/f4LhsYKhXFb57SNpljGMkX+o8SCgkwTl47sG9JmsS2IkakCS7Z2uNnZMqlJE
	EVloF8ywEHiGJoQdv+jzMA5FJUA4z6oMVKeK7OV3eihLIRcdFU3FWtR/iWhjvH/+nwHvaEcRqHN
	CGkuPuYx1wbjFP++kNAWzFsV4fzhF7MH1VRAK7Ggd8m6Wa9416IJcxxGf4bc9n3tp1chRpXhkMy
	FoWZkKEb4CxJMs=
X-Received: by 2002:a05:6000:2509:b0:436:369f:39f5 with SMTP id ffacd0b85a97d-439f8423e9cmr8686121f8f.43.1773271597106;
        Wed, 11 Mar 2026 16:26:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3907:95a7:853e:a714? ([2001:8b0:aba:5f3c:3907:95a7:853e:a714])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186d5sm2886479f8f.28.2026.03.11.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:26:35 -0700 (PDT)
Message-ID: <fc5468c04fc393f098ffeb1ea37c4332587ddd59.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] utils: add is_enabled function
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pierre-loup.gosse@smile.fr, bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2026 23:26:33 +0000
In-Reply-To: <20260311131917.2203296-1-pierre-loup.gosse@smile.fr>
References: <20260311131917.2203296-1-pierre-loup.gosse@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 23:26:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19147

On Wed, 2026-03-11 at 14:19 +0100, Pierre-loup GOSSE via lists.openembedded=
.org wrote:
> From: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
>=20
> Check the boolean value of the variable and return the 'truevalue' or
> the 'falsevalue'.
>=20
> This simplify the following syntax:
>=20
> =C2=A0 "${@ 'truevalue' if bb.utils.to_boolean(d.getVar('VARIABLE')) else=
 'falsevalue'}"
>=20
> To:
>=20
> =C2=A0 "${@bb.utils.is_enabled('VARIABLE', 'truevalue', 'falsevalue', d)}=
"
>=20
> Signed-off-by: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
> ---
> Note: Once merged, a patch with the new function will be submitted to the
> documentation mailing list.
> ---
> =C2=A0lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++
> =C2=A01 file changed, 31 insertions(+)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index b2bda08cb..9937994db 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1272,6 +1272,37 @@ def to_boolean(string, default=3DNone):
> =C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ValueError("Invali=
d value for to_boolean: %s" % string)
> =C2=A0
> +def is_enabled(variable, truevalue, falsevalue, d):
> +=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0 Check the boolean value of the variable.
> +
> +=C2=A0=C2=A0=C2=A0 Arguments:
> +
> +=C2=A0=C2=A0=C2=A0 -=C2=A0 ``variable``: the variable name. This will be=
 fetched and expanded (using
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.getVar(variable)).
> +=C2=A0=C2=A0=C2=A0 -=C2=A0 ``truevalue``: the value to return if the boo=
lean value is True.
> +=C2=A0=C2=A0=C2=A0 -=C2=A0 ``falsevalue``: the value to return if the bo=
olean value is False.
> +=C2=A0=C2=A0=C2=A0 -=C2=A0 ``d``: the data store.
> +
> +=C2=A0=C2=A0=C2=A0 Returns ``truevalue`` if the variable boolean value i=
s True, ``falsevalue``
> +=C2=A0=C2=A0=C2=A0 otherwise.
> +=C2=A0=C2=A0=C2=A0 """
> +
> +=C2=A0=C2=A0=C2=A0 val =3D d.getVar(variable)
> +=C2=A0=C2=A0=C2=A0 if not val:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return falsevalue
> +
> +=C2=A0=C2=A0=C2=A0 if isinstance(val, int):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return truevalue if val else =
falsevalue
> +
> +=C2=A0=C2=A0=C2=A0 normalized =3D val.lower()
> +=C2=A0=C2=A0=C2=A0 if normalized in ("y", "yes", "1", "true"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return truevalue
> +=C2=A0=C2=A0=C2=A0 elif normalized in ("n", "no", "0", "false"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return falsevalue
> +=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ValueError("Invalid val=
ue for is_enabled: %s" % val)
> +

This looks like it duplicates much of the to_boolean() code and I'd
prefer it didn't so we only have one copy of "true" and "false" values
to maintain. Can't you call to_boolean() from this function?

Cheers,

Richard

