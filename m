Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2325.1795200381854570314
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2026 10:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UKdjbVI+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso21813585e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795200380; x=1795805180; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mo4ekiQVgwxDvMCAoqnaJzR6CE5kxyyDSVj8LxoEzwI=;
        b=UKdjbVI+eY1WDjoijlT8W/Gf1trpQVIBwxXCPIP6LzXJ8PdhD0j/hv+9VGjHk59ciD
         qck91TumrHHAzqWFHBO3PDyh7+Sa1UsrU9BgLAv8WJMSNUrThgl/fGzbFPGrYY/x4pl0
         fmZh7DE7joDXFMLGQhQMoWL2oEZWbHUBEvoJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200380; x=1795805180;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mo4ekiQVgwxDvMCAoqnaJzR6CE5kxyyDSVj8LxoEzwI=;
        b=G1U/M6QHiyDOuOwsa5BcFNOf6pipq1+DH9jZd87Q46DqcDgeXCuA1JU3+hdeCTRPsu
         uFoks5psE7gKRmUn4SHnQ+k5zyhhVWN1vStxCWv7veSmINF55fqo8MAA/29ChE+MMtzC
         LYWeYSYwcOlR9UVjqmQ9P0chkN1jXxvNZGZ7gLsMRrKKx7OFJuBx1qXSqUarfAZqOlAP
         5SxXBzuizUF8hDNtYBHgwDr+yczMzWVBQ00VNNwQHn9JXwx0EXnl/1ZpD5HLJ6IObZPp
         LkTN57m3o1Cz86Nbp9MaXXAsaYOJWXK63rCb0VpwvdnfW9OJyVptOfSbKfvMTRMErQmD
         wxlA==
X-Forwarded-Encrypted: i=1; AL+hErFe4KTvmnVoPcgEX4UsCUSvS01d2c1ea3ZM+b4+SNUcINZG01lXGO1EJ8RN0bL9cBYDSzt17bFAt61b9G+P@lists.openembedded.org
X-Gm-Message-State: APuU4Z/JHshJinwzmZhKtPv2hih6q0f42isaUWvvO/DeuYbPJqAMHMpA
	LY/ciJLQrK6UFeIO4pWCHjqlTwUVPnufJ5RM1h+8O+bCdVoS+46k3/gsDSmcSc7PS9s=
X-Gm-Gg: AYBFou3PeD+ZAKDTsNXYNiwXMj/u02LhHqka8OcqP1xCeovJ4EJgRKeFv8RWsy9XwK2
	EwDRqho/gbUtnU/+pJ8bHaL9IiN2vd8Ho/JtZv5Z94tH3FMWfPLpX1GsiZJE3FUpff/QUTkbiIJ
	H18k6GphkMTPoa8NS10kSYqXJliDqTtbkH/eMsRN43r7QStlFpnQoAchq/pUVs2TiujGWZZf65X
	Ot10I7CHuiG6fi4gxE4V6LZDp7YKvYeLc6D4zoSHdeQw/o/Y/AlZ9cEuNz9xKYdBpLO/cyvnpcO
	nXi89Y2zFhQbhhFMyKkdJLWe2gTWek5+qkRLIvPjUdbbIrmD+ShvYiizIFZAB2RUW4VWXH64Io1
	PO08QBTpibMYLp0SKbF+Ge3SEvtWX18YlU6QHl3n4k0I0MIa2UJIzRd4Q3OU7syryiKIGQpBp18
	Ch2r1FFFHPI8SWfUxk3zS59CNgUafy/a/iz0qWQUTPSe9uv9N4ADvjvo+1oqmIsxPbDCZLM1J89
	GPHATDOB16IKrRuyBJJZihm+9BQqWZyRFiOAOQae/uONpk1r/sjaPbdpN/2iA3Xisul9Rl05Jon
	pCnHRdwrC3+zjMHwdELxSV6eaV5ttsKaH5co1reZ1U0pBND7Dv3kSoyZjpmvDCqu/h4rbaTEe8G
	ssr/SOKPOBvK7mImYhA==
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb887fc396mr91130485e9.3.1795200380054;
        Fri, 20 Nov 2026 10:46:20 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:ade0:e24c:97d2:ceef? ([2001:8b0:aba:5f3c:ade0:e24c:97d2:ceef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm4331995e9.4.2026.11.20.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:46:19 -0800 (PST)
Message-ID: <196178d920291fb292393e16233869c08f077760.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] cooker: Write variables that are
 not JSON types to the event log
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stondo@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>, Alexander Kanavin	
 <alex.kanavin@gmail.com>, Stefan Herbrechtsmeier	
 <stefan.herbrechtsmeier@weidmueller.com>, Peter Marko
 <peter.marko@siemens.com>, 	stefano.tondo.ext@siemens.com
Date: Fri, 20 Nov 2026 18:46:18 +0000
In-Reply-To: <20261120135323.2627478-2-stondo@gmail.com>
References: <20261120135323.2627478-1-stondo@gmail.com>
	 <20261120135323.2627478-2-stondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 18:46:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20468

On Fri, 2026-11-20 at 14:53 +0100, Stefano Tondo via bitbake-devel wrote:
> From: Stefano Tondo <stefano.tondo.ext@siemens.com>
>=20
> EventWriter.write_variables() writes the history of all variables to
> the event log as JSON. A variable can hold a Python object. For
> example, sstate.bbclass stores compiled regular expressions in
> _SSTATE_EXCLUDEDEPS_SYSROOT during a build. When the same server runs
> a second build, json.dumps() fails:
>=20
> =C2=A0 TypeError: Object of type Pattern is not JSON serializable
>=20
> This occurs with tinfoil, for example in "recipetool create", which
> starts more than one build in one server.
>=20
> Write such values as strings.

This worries me a bit (well, a lot!), specifically the "second build"
piece. Why is this persisting across builds? Does:

https://git.openembedded.org/bitbake/commit/?id=3D606786d17351534ce35d1b0f8=
9815461546a66fe

have any effect on that?

Cheers,

Richard
