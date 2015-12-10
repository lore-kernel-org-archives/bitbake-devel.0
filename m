Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id C2834606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 08:07:02 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id c201so20135048wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 00:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=hi/qqzvBcyemM+PNDlDAUPNWIJH3O+Qf0ReeckcKTEg=;
	b=eqbdUg/BwLIMt1s95wgVXnRZHE/VnwxOYhXaokAPFZ+NXzmPy6vah3Ck+SngvXeKHF
	tYSZcoyQ3T78ljCaG+HhevFNDBkVQbP4i8LEcfQL8HH0B9e6enUad2wjHKr4MzE9qhGc
	XXgZrGjk+39UmFj9pVMz9Fi3HNF6+ClOI4WGBeucyUQ0QGMUskMpbe0w7p4Rx8EZnd8k
	Ju80BU2BkQKhIM1jkH8iri05JQVIimgESOFFyzAG74XNrXxgLrnH8Zu3GuzyHhplV3JI
	XzVziHQHIIMhKvrDJB6Z4ayTr4aBZb4VOadd86nsDobYrVLeFPB1Lm/YZTtChCyMvEbx
	PqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:content-transfer-encoding;
	bh=hi/qqzvBcyemM+PNDlDAUPNWIJH3O+Qf0ReeckcKTEg=;
	b=gPlZwdfrBoFjCGvLJpsVz0Alkt/unPmlb+rzUbaJ32yRGfd9HldBpNSeubvMhQJ3LV
	lOs892t2KgidWxZWsflIfmj3dJxb5FCPoLxDlX7lQUsJvOsIsGTPLd901ECow+1VWK5Z
	vc7/g38GKlRGbvhYoqCNc8toPpuCOVG8auHIGs6qXmvNZQDO8lFZkspb5h7BEgYto3dL
	iGeiCoPowCXWy3qoGEr89Xx69o7mYmlb508ionXZt3m34ZhlMLWmU1wBkDf8svT1tvtf
	Hsg9RaUh4cd/uUl7vjGaBunv17qdqz18xFyYKpv/J7oLtRRZODvOxgb066Tq/GEtO+SF
	AJlw==
X-Gm-Message-State: ALoCoQlmGl+q8kJD3rjBCYMRQa7trYOqL2JReGUnZqqIwVrdY1CxWC2dbw0xk9lqfcIVuMCZhHmiW+t2Yk/B9VQXwI455wn05PouoKZ26k8FpmMWk7YeiJE=
X-Received: by 10.28.57.65 with SMTP id g62mr36998730wma.65.1449734822688;
	Thu, 10 Dec 2015 00:07:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.184.110 with HTTP; Thu, 10 Dec 2015 00:06:43 -0800 (PST)
In-Reply-To: <39C63A78-9861-4FFE-A6F7-0A7183312908@gmail.com>
References: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
	<CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
	<39C63A78-9861-4FFE-A6F7-0A7183312908@gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 10 Dec 2015 09:06:43 +0100
Message-ID: <CAP71WjzwcSCk6_4Au2U_3tiK8pzfSycQu2r-OFH_QnWsKDR4Gw@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: PREFERRED_VERSION with % wildcard picking unexpected version
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
X-List-Received-Date: Thu, 10 Dec 2015 08:07:06 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2015 at 12:32 AM, Khem Raj <raj.khem@gmail.com> wrote:
> whats the order of your layer in bitbake search path. Secondly whats the =
LAYER_PRIORITY
> if they are higher than oe-core then it will always choose the provider f=
rom the higher order layer
> versions don=E2=80=99t matter.

you're right. It's a priority issue. meta-linaro-toolchain has a very
high priority.. I keep forgetting about this rule..
thanks

