Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id E8C1660234
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 12:16:24 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id w15so15824601wru.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 04:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=PgvYUaSWAVPaUAJMGvk+m5YW9wLyTeGWeAbbd0ZB/Ms=;
	b=VozOn/V7D52djoA6E0Uempw0vox3rw/XfsfKyX8SGjQ5nk7A3utTQ8WeRVvSU8ad97
	zaRgUUVvz4z4feELZb+lNvjenJ8NDwo/tHYRxCwXSXY7yj1NhQm48o6FAbt4ZItWROje
	NsyaWfYtmNJpkwy+8GapM9JPJiN3mkQBOMSUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=PgvYUaSWAVPaUAJMGvk+m5YW9wLyTeGWeAbbd0ZB/Ms=;
	b=CZ3h090WaHntxrGiutfab/5Yx2nzIlxK7yTKe7TGGkpteajSeEEZBY2maFwNCW1gbz
	mWenTxbs9YtEkJvxv69gpU7WSxEMJ78QUyieCnTJyNNWu53+PbSZZ+yyb28PJypdOMZJ
	jN3zerbVnhBJ0hYJxM9mlCoPnGAj4TOAqbtvTGIs7qaYY8fQlHjyWASwKBTlp4sIl2DS
	ieXOp7zLAibSlSgFXWnABIcnqg802hnc0HGzBDhmE10gbkrM7XLyKT9w0j6ElQ7OTOvi
	oc84TqUvif7g0J6iIp5EwKR79umNum054kPHHzXDvfw8QpGGNCRrJpb8oDXQwi7SQ9gq
	GANw==
X-Gm-Message-State: APjAAAVmvJQbuKgxZsC7hjTDz4sGRMp1o9g4G9GtmvYj2mGTl7ZV7smk
	TszRRrHcgexZTGrGR63ydVA/KA==
X-Google-Smtp-Source: APXvYqyPMpWS9eAhHG9kihr7Tf0E76tOwa7FLvMtNe9xmF1oiRuKbit/7MDkuMkBngfdg4Bn9rti8A==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr53905791wrn.351.1577535384875; 
	Sat, 28 Dec 2019 04:16:24 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id c5sm14289983wmb.9.2019.12.28.04.16.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 28 Dec 2019 04:16:24 -0800 (PST)
Message-ID: <12d09040023dd88ae6fa2397e14929242d8ff317.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Masahiro Yamada <masahiroy@kernel.org>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 28 Dec 2019 12:16:23 +0000
In-Reply-To: <CAK7LNAQ+4TEnV+hW9ZQpn5dK+brp9o6UfD3OLk++eHn4T_ezxQ@mail.gmail.com>
References: <CAK7LNAQ+4TEnV+hW9ZQpn5dK+brp9o6UfD3OLk++eHn4T_ezxQ@mail.gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: DEPENDS vs RDEPENDS from bitbake PoV
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
X-List-Received-Date: Sat, 28 Dec 2019 12:16:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-12-25 at 16:33 +0900, Masahiro Yamada wrote:
> So, DEPENDS and RDEPENDS are fundamentally the same
> from the bitbake point of view.
> Is my understanding correct?

From that perspective, yes, they both have the same dependency
behaviour.

> I know there is slight difference between them.
> For the RDEPENDS variant, the form RDEPENDS_<pkg> is also supported.
> (<pkg> is the element in ${PACKAGES}, or ${PN} if ${PACKAGES} is
> empty).
> 
> Other than that, the functionality looks the same between
> DEPENDS and RDEPENDS.

The namespace difference is key, deptask works off DEPENDS, rdeptask of
RDEPENDS and as you mention, RDEPENDS has a relationship with PACKAGES
and RDEPENDS_<pkg>.

Cheers,

Richard


