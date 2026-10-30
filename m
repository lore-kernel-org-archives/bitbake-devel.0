Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13029.1793370961973677255
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2026 07:36:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DoIgGQDI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so7849505e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793370960; x=1793975760; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HtFthkkWna30marnjE9nd/5iv5kR3bpEAKBbjv8xpS4=;
        b=DoIgGQDImLr+6AfVlvcPFfx4aWUQdD92tWs8pYcsi1ikayf6EMv9lYsBFsJ874mugC
         Kd2QMIl5HYTO7NPFJLz8VtcmwDaXq8cbOikDDdolSIHvLgL7PO6HwbY5enPxEXKdIOjZ
         Sx+leatY/JImRHm8KytO9YYXBUurvyBVM4CEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370960; x=1793975760;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtFthkkWna30marnjE9nd/5iv5kR3bpEAKBbjv8xpS4=;
        b=HTR6T0l9heD/J4otYzRPu5/Di3zqC45QKgVAsMhHNvQKn2LHvXcF3vM7G167tGCCmo
         wsECHLMLunCwH0WvnzzbaYIr1/9oCVOgmY/zr9g/P7kzu+X8hjffvZYBMBwSe8JjIbIl
         pbpv7FWYffmoEWt+wf8S+k6cP6vBXY1HehzKgoEdLjUyN/wfi56nkDhfO8gvK9nLrB/J
         5OmFbi2K9b7FuA+6o1fHESRC2GC13Jnmf2vMSLUqZMY6fyaqt8NtYEOJL3y8tklBKw6x
         VmAJRc8oN0TemnOSEk9lT8B5rUJIoWje9s6FnRe2lkOyI2Yq17V3gQWiL9Tq4QITnzlQ
         txTA==
X-Forwarded-Encrypted: i=1; AKwUvByO0lcLaAg8UuyWAOlZnLbKjZbo5VQ6rw8hlpOgMZPOm3U7r/BiPnDxpEFcaUz9JumMVLNWnYTA73yMrPNJ@lists.openembedded.org
X-Gm-Message-State: AFq9FYIajkUJQBHs7oTYPyDZhiw+40UtBSiEPxPp3Ud1bgnxcgI2pS98
	PWilAp7fYWoNzzSNu/FRIdCxMVfBVyPbWWapRAeRZEMsAOKg56IimEBdvUrT6iLzO5s=
X-Gm-Gg: AYBFou0limcguh03oMivB96c3hijZ7gjt/OS/xLw4/AyKtZGXZsIeRpM/acD6SEyuTd
	826D+WXR/DDQp0SwMCR2AgadaXPBSCOQY3+pbiLvYJwIlb/jhb6CZdD3fbdhA/P14jrnzmwlFNr
	9XG/P3Qe2WMdznwb0H98cuHzr7EFjuNMpcVxcnBjg4Wit/pWIA219DFtdBrvuPxF9UP4x+2RCDD
	i2j3dwxJgA/hh+E4+iioXhxCygoUi4J1880i0NVarKX1KG39ur07ZNKcsVEXurtf04BvfOpDTDs
	QlvjwhMSzczGqvZdMrLDTOMcc8b7GtZ1r4G365c0bXLSXAFwCJaBVdC+5p5pm4vP+Ez9l5e/rhT
	EFi2RHxeLutI1LZyQZ7UStrsrF29DkFt3Z4WWYkHRw3pPszD+SYNC9+G3/x7rvkz2JwmH+O0LcX
	5fKJP4WfXPVcjdqFyV5ZfV2vuelaNugKKZa/zRH4Y1ROZMqcWPUdhBuJVetuEgvuToVVNOQL+C5
	eAdfrC03Bgz9/9pZONc/9bC9KwzyVBPSBbgaNOOllbQ9cCVhUwv9JQ4DydmJpATWyJ33kQkChXF
	0mVq0jljUQXMc1JAGpqfqqU5SeNHUN7UgfwIYfCDUVvrFlud/lBMFoiSpazHqOjJKExFzylZ09v
	sGuPhcUJ2iDU+0z/tiQ==
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4ac17b2cde9mr62272245e9.7.1793370960145;
        Fri, 30 Oct 2026 07:36:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:50a1:2666:faf3:9570? ([2001:8b0:aba:5f3c:50a1:2666:faf3:9570])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm101395145e9.3.2026.10.30.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:35:59 -0700 (PDT)
Message-ID: <486d4afedb19e2f7824cc9572434de927b34c894.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] dump-signatures: argument mismatch between
 bitbake doc and oe-core code
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: andreas.muetzel@emlix.com, bitbake-devel@lists.openembedded.org
Date: Fri, 30 Oct 2026 14:35:58 +0000
In-Reply-To: <xOOtQA9cT-CHOwye467idg@emlix.com>
References: <xOOtQA9cT-CHOwye467idg@emlix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 14:36:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20384

On Fri, 2026-10-30 at 09:37 +0100, Andreas M=C3=BCtzel via bitbake-devel wr=
ote:
> Hi all,
>=20
> I just encountered an issue when trying to dump/lock sstate signatures in=
 a=20
> project:=20
> bitbake-user-manual-intro.rst and the bitbake help text say that
> "bitbake -S none <recipe>" should create the file locked-sigs.inc contain=
ing=20
> the SSTATE signatures of all tasks required for the recipe. But this sile=
ntly=20
> does nothing - the file is not created.
>=20
> Since oe-core commit ad57c3cac2a8d3e60222e3cca0685f582dcea135, the actual=
 call=20
> is "bitbake -S lockedsigs <recipe>".
>=20
> Before sending a patch to update the bitbake documentation, I'd like to=
=20
> confirm: This is a problem that should be fixed on the bitbake documentat=
ion=20
> side and not in oe-core, right?
> The call from oe-core makes much more sense to me, but I may be missing s=
ome=20
> kind of bigger picture here.

Yes, as you say, we added that mode and have forgotten to update the
docs. A patch is very welcome, well spotted!

Cheers,

Richard
