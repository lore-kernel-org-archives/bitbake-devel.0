Return-Path: <akuster@mvista.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 4F54F7F816
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 22:00:53 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id h27so1183703pgn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=ZzHmfl2K5okkRFdH3i/3+CdR3yEAtKuHzWrePdCwVJE=;
	b=mk0SinnHYekTFmOckVhF4CUVyv5HrdiFw3Fvy65bjNyM1weDxJ+h+J/RO+e+KX0Igy
	eClz5gXA8iADTwUdNe2l5DZ4nCZ8dUt5xU+k1/5QrvNQKmY0piGGMuUbIyx/hVl+HYhQ
	vxifveoy6nqgv2kMcBPJVlA2P+mVItm+iTNENPVAke5MHNDnIGV7qZzdciQpzo6UvSbe
	y//ovRAS4iMFQhj1e5UWD86Y2ExwiSMZWD4NgG4OY4MDnj+dsttn20K3uQDLMLfI5Ez1
	4BqBveSxLyZifBtsoAIpyW3uWsKxlGrRxt7v07ws7BlzK97oGeM82dVAnA+x2LFx78z1
	v4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=ZzHmfl2K5okkRFdH3i/3+CdR3yEAtKuHzWrePdCwVJE=;
	b=eiLrsfe6R1nV1SDK3IXT5JuSqcWLBbsMtI0QuS9Ttsmj8IqTRrk92imkcndC5rsvry
	LoYachJxDXRC8p6D0uqD8bSnjZdQHwxO1EOsiO/TjLy3/lLJTDtf14a+SSES4lFbwq64
	Jxsa9RxHgpT6RRUQ1zmtCXryVfBU7KhKjxyA75xZZfMtPsP/Yil+t+maRcio2U54C4Sm
	sMBKuBDoVyNVYv+7wt3rK6V5xqO66plw9Nc1aO7wJN7BmPi3Fgm+IloLt/Uy6UjmEeXM
	6J+s1ProPEsJqtHIcPBl0evdwYfSIxpCwbTQeJyn/ROY6CAU2wC1Pr884oarRIAx2z1C
	DVCg==
X-Gm-Message-State: APjAAAWsu5thCa2fplHQ8rbm6+Z9z3+aRs43vr/98T1dokGiswDBtkxy
	2eBoXx6EoEnpFIRN9pfbB6rB8VkxrnA=
X-Google-Smtp-Source: APXvYqzlQvulybUjR7SjcgeDf9hhmYZ9wGA6JgiuYvDvjF0t4+0cjlantaICBkoLahR0kSDf03t00A==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr149298pgg.134.1573077654475; 
	Wed, 06 Nov 2019 14:00:54 -0800 (PST)
Received: from [10.52.14.175] ([162.249.178.141])
	by smtp.gmail.com with ESMTPSA id
	q185sm36973619pfc.153.2019.11.06.14.00.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 06 Nov 2019 14:00:53 -0800 (PST)
To: Ivan Efimov <i.efimov@inango-systems.com>,
	bitbake-devel@lists.openembedded.org
References: <20191105140735.8204-1-i.efimov@inango-systems.com>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	mQINBFnlUP4BEADpKf+FQdLykenQXKk8i6xJNxDow+ypFeVAy8iFJp7Dsev+BtwUFo8VG7hx
	Jmd71vHMw+coBetWC3lk+IKjX815Ox0puYXQVRRtI+yMCgd6ib3oGxoQ8tCMwhf9c9/aKjaz
	mP97lWgGHbiEVsDpjzmMZGlJ6pDVZzxykkJExKaosE46AcA8KvfhRQg5zRyYBtinzs8Zu8AP
	aquZVHNXxPwjKPaSEEYqQjFeiNgFTavV+AhM2dmPmGUWCX9RZisrqA4slGwEB0srMdFf12Zg
	mD35Y9jZ80qpu5LPtJCFcsaAlebqR+dg36pIpiRR+olhN1wmC6LYP1vw6uMEYBjkTa2Rnb6+
	C4FDzCJD4UCrUvLMNeTW810DY0bjMMj3SfmSGSfQUssaaaTXCVlLGuGxyCr/kza1rHaXMKum
	Ek4EFj1fyn7AfkSLEHfJfY4sO1tpgigvs4eD/4ZSQEXSu/TjVvyKx4EvUbhlGMRyH2CPwD/H
	7DFF8tcVtJvCwUUW+zKtjxjSSLrhniNMXAOQJZ6CdaqCe4OyJQT5aRdr+FWbBRjpaRCCf5nf
	dTc88NMU9PrBT3vu0QJ5WNPO6MJpnb+d8iMNLZAz8tv8JMm2l+sMcNKSJ6lhX8peoBsfMVqc
	FgiykEO0fUt7DCbUYR5tLjM/3E5tHvTjMooVJyOxoufVLYtTtQARAQABtCFha3VzdGVyODA4
	IDxha3VzdGVyODA4QGdtYWlsLmNvbT6JAj0EEwEIACcFAlnlUP4CGyMFCQlmAYAFCwkIBwIG
	FQgJCgsCBBYCAwECHgECF4AACgkQ7ou0mfRW5/kuhRAAlR2FTq5572jrX5nnPR7AqI2bvSVb
	vqGLlvv739WhghvagbC+tu05QguopAhWW1/DcHK2+QtfIoC9UZrSW4RaO0CCo5sPjqK7l1KT
	ngWX/rGjF6xTF2QN0U/btcpMyVN2CNtVLwsDF9e+GHKoUcnFkP+JP8vHGokN9k6E/c97hLaL
	IJPeKl8LZXc2Efk+MaW1NXkfDJdcp/p+voajbihSQO6OZ/o+x9d2I3ZybKfTZ71+ek5Hxzjz
	g6KkMOI7KJjlmBlrQFAtVbS+CFAKrwkYznE6ggkcmGv3N7DeUBTUR78hf+EZEAM+ajeLMtrG
	rXE00pIb+gLGYPZxba5pCdQ+qWUW38qi9UnIRPm6fq7Ypx1r6XwJvbgCOkhbxo3D4YUdyC0b
	FE9lgrg8htbc9in4j2+hVI6ALswNjLprzXdzdKrd+T3Egx36o3Z/qrYsW2o5/A5sVvvASVKi
	wRPuEKhEhfmiHUPLvuKqhMoymHaz3fg5D2Q8G0gSDkLgeEpAjiWqf4+AGLx+MSDai7DSOsmI
	t61kWxs7cFTB32UrB/TDoVNn3Fm88ZFQpA/bngikE9jgEm045mSY86fNlbFj2mcCd0Ha1i1n
	aYc97RpgfjNMWyHDVHOGrNg/hJjkGa5RsAXkfyBwltHRw0Hj4urUQ3rr8um8PLe43SezPwXA
	oRoyDxC5Ag0EWeVQ/gEQALNHwj5VSPdnvXy1RXUuH+rclMx4x8zaqDyY0YqHfA7b/d8Y0VAt
	Y6YpzDeFTwD8A0Wfb7kZ2mlDIE6ODCB71uT/E3C6b+FiiN+lgzslznjUW+9l8ddDhRrC8HMG
	37vrXF5h++PTXUKEKUlkDib1w093tu3mlJXUvIAzl8CEHkptF6Br0L9XxFwuWoNUfjT9IorQ
	0SVIhvq5PhVAITXUD5fD7/N8B4TYegmHFRo1UaaKSnSHwlJJkzKpeWOH8QTYrP0RHxX86Obv
	IZuwbAo3F3oojcvLJt9NxWnbEmEALkleklLZnukgu7q5Wp1VDwhUbMFTLb6qmnBa/Xi30uOk
	0l1TMHDbeQswvQDOZBAMukSRqyBetKxQ3iTfZ/3z1ubQRcVDbVlMDScSHQq0LK3F9yMOMM/6
	0QPqJjl13xn/+Bn7WJiAIXXwzAV7uo6i0khFfjDtCDQ40aeffqOLxp1yMLkc3EKJGcQ5F6O2
	ycEf4QXCYUbMXjxB0EJB8y7z+xOi5Mmd/pPlVmZ2gQK84NAL90p7n7jRlyf3gOUY+JOl4c5e
	UFiIhOzmuqNrvPOiZ02GXh6SGUU5y7IgSoIKvXSFgHAn2OG/tcspBmkyv6IuNVpmbmEgYn4I
	Rnt40UXVQkxTh0dENFhk2cjunMYozV/OqYCgmZLFSeJd8kAo4yn+yOtNABEBAAGJAiUEGAEI
	AA8FAlnlUP4CGwwFCQlmAYAACgkQ7ou0mfRW5/nNcg//R63cbOS6zLtvdnPub3Ssp1Ft8Wmv
	mni+kccuNApuDV7d63QckYxjAfUv2zYMLpbh87gVbLyCq9ASn552EbfRhTvHdk44CgbHBVcI
	ZBEdZWgRR5ViJakQSYHpP2e5AGNFnx9gSIuRTaa5rvZM+4xeoZ2vJiq93TtaYPr7UFNfK+c4
	vv4C66lkt9l95/I10eSc3RqbOKZW47emlg4X3ygEoB9k2lPrpspyf6sUuSEi0WrlSxoLAr6p
	JG8rTUErYNeXe6JCdL31odDx1Dh5sdKIj2RicUYZNilxu9f1M7jZwf2ra1FGAlKj2ybqmgpZ
	EFteaiCinEYsvDyZyOiWHjAFI+RZIPQQL3AnVp4l7wYD3r9hnqYPww0slyMDcb9262RoFkHq
	dDwxPYarrNjWUpOzxB6bFxOgNRdCTgvQl8Ftk8a/yXB6vHeUSm1vPFCBxQPZytyfOLhEWm0J
	/mkVL0Z6iRK3p1LKnpLYCS4/esL2u7RrhPyCs2SsL58YcQF/g+PpeT9geZ+oyZ/4IQ+TWJoU
	PNHndk8VBTpzrmOaJxrebNL/W6C8JCmbLM11TAUMmHYi9JDytN8Au78hWpDbIdKwg1LeSxpw
	ZZD/OqOc0DBvHOpQhzkSrtR1lVlDV/+9E8J1T4uDhrGmZwYV+4xQetypHax8aAHisYbjXdVa
	8CS2NxU=
Message-ID: <c080c0f1-426e-e40a-c4f5-3e66c6f7fd86@mvista.com>
Date: Wed, 6 Nov 2019 14:00:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105140735.8204-1-i.efimov@inango-systems.com>
Subject: Re: [1.32][PATCH] bitbake-worker child process create group before registering SIGTERM handler
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
X-List-Received-Date: Wed, 06 Nov 2019 22:00:54 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 11/5/19 6:07 AM, Ivan Efimov via bitbake-devel wrote:
> The bitbake-worker child on the SIGTERM signal handling send the SIGTERM to all
> processes in it's process group. In cases when the bitbake-worker child got
> SIGTERM after registering own SIGTERM handler and before the os.setsid() call
> it can send SIGTERM to unwanted processes.
>
> In the worst case during SIGTERM processing the bitbake-worker child can be in
> the group of the process that started BitBake itself. As a result it can kill
> processes that not related to BitBake at all.
>
> Signed-off-by: Ivan Efimov <i.efimov@inango-systems.com>

I see master and 1.32 have patches. To confirm, 1.44, 140.1.38, 1.36,...
need this too?

- Armin
> ---
>  bin/bitbake-worker | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index db3c4b18..6a12a31c 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -189,9 +189,6 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
>              global worker_pipe_lock
>              pipein.close()
>  
> -            signal.signal(signal.SIGTERM, sigterm_handler)
> -            # Let SIGHUP exit as SIGTERM
> -            signal.signal(signal.SIGHUP, sigterm_handler)
>              bb.utils.signal_on_parent_exit("SIGTERM")
>  
>              # Save out the PID so that the event can include it the
> @@ -206,6 +203,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
>              # This ensures signals sent to the controlling terminal like Ctrl+C
>              # don't stop the child processes.
>              os.setsid()
> +
> +            signal.signal(signal.SIGTERM, sigterm_handler)
> +            # Let SIGHUP exit as SIGTERM
> +            signal.signal(signal.SIGHUP, sigterm_handler)
> +
>              # No stdin
>              newsi = os.open(os.devnull, os.O_RDWR)
>              os.dup2(newsi, sys.stdin.fileno())


