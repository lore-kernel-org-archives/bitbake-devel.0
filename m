Return-Path: <mghirbi.bechir@gmail.com>
Received: from mail-ot0-f172.google.com (mail-ot0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id 81FB274E86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2018 13:10:22 +0000 (UTC)
Received: by mail-ot0-f172.google.com with SMTP id n3-v6so85568ota.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2018 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=Jq5WMuq1kyvzQ/W0k6zoRuEd1p5qDzLt5E3t7TZKvmg=;
	b=D8ujHoBNggqNCc6gzjmcmfkPBCfxQUbSxlWW2J7tvk0QDV4qxSFiyElGA//52m7sIn
	rYryq8voiiz3k8TBPcsw2DCkR1PXTxACgI1POsUe91HLYj+U9ksxxwxC/q86l0uZjxzJ
	PrKoXRZ57fsUE2A1Z0McVVgk9RLenQSUYYnwEzM/HAJuolNN4VCq6zlKEWBGiCwj+IpC
	N9ZbBwABrmUJxQVRMdSsfenujpmkTXbYNMoVvJhEV/RW6MbSzAr4Cr7r6buml3cRLX3c
	Pld19xdcKm9cMzfASbc2X3airTWa44v23a9Bo7u+tjKp7eLgoblfaI7mQ0x4l/41x1td
	4Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=Jq5WMuq1kyvzQ/W0k6zoRuEd1p5qDzLt5E3t7TZKvmg=;
	b=JaZLpRjxhrnBumkXcgUauDk9SLpTLG/DWdeaL/0fGiXJ9c/UgfPJYknE3vZ//KbWB5
	AILWn2cRKRZiZlzVxefnyJO+dKuGCZw017fPvLKHBciqKg/iv4r3/ZSs3IWvv1NHKbUy
	fKcJlIQAr2BUO22n+Cu3y9Dqkw8p21ifgzExMjTaSbm97I2nlAYgVl/HKa6pGJwrtvMU
	BB0zqjdTt5zpUXKGXWiv+tf7GsS2zE40qh8SI1vOLrp5r7/i7Yt1b5m0irWeOTp745in
	O5DeEjOrKJTBwWC2FD+nSm8uHWkPDnhDEwHUR1AguGCPxwIKIbC/qbtzwsZ/YAxTXPCV
	xwmg==
X-Gm-Message-State: ALKqPwcdH3dwaNBuJkwxbjovBXdjKXaAuzukR9l8Zllcjv148FZtfWlP
	1Ky0qkU/8001IFi3niqPtaLt5T8+KGCVLrFln4l89hJh
X-Google-Smtp-Source: AB8JxZrFdUJw47teO/HVS6VGIgQW9TvoBy9/cEJoTv6bck1KoZnhDx1QdZ4YN+ZoaUJpCU5zPEdgoZS6QtBxa9JVxPQ=
X-Received: by 2002:a9d:11f4:: with SMTP id
	y49-v6mr11213364oty.163.1526389822866; 
	Tue, 15 May 2018 06:10:22 -0700 (PDT)
MIME-Version: 1.0
From: Bechir MGHIRBI <mghirbi.bechir@gmail.com>
Date: Tue, 15 May 2018 15:09:55 +0200
Message-ID: <CAJ2U5c4vxPy7_ZQ=zSW_P4f6KNAvOgHw5smF4r6K7eEiWtp8cQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Listing package source URL for a given image
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
X-List-Received-Date: Tue, 15 May 2018 13:10:22 -0000
Content-Type: text/plain; charset="UTF-8"

I'm currently trying to list URLs of all packages needed to build my image;
say core-image-minimal without actually downloading files.
Googling this topic pointed me to several options: parsing logs of `bitbake
core-image-minimal -c fetchall`, usage of recipe-depends.dot and `bitbake
-e` ...

Is there any *easier* way to do so ?

Ideally, I was looking for a command line similar to:
$> bitbake core-image-minimal -c fetchall --print-url-only

Any hints ?

