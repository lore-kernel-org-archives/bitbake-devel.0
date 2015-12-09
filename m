Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 7A1EF607AB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 23:27:55 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id w144so2207775wmw.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=uRP3ezzgFeA6PA9L6hGU+PFYnhIg6psbXQL+LLwSnqQ=;
	b=bTE7Q7al9uirc9c2Dwtk289blts3rmhTJNj00/TWPhtP/Xd7RcBDML4s1R2IM7yBZW
	1F6nuW7PUmzITYGIpdQkrelrl9DNnRD6XHywuxlx872XZg0AUc2PsDK20yqlmWRpqT3M
	SZpy/TtlVoQ7RLp7w3sZZKdmJVih6/5EHhl30Sm1drkuuGC5DFrxmiVq7qdr2C3HS1ES
	Rh5JFUmco9vPUc7ROnpbbR6NluoheGrANcfWc00Nn9r9D9WaEms3tDyTLXK//pQK/v36
	9d/aiP7TUxDs5I4Zicmx2VdeYX1B7mxIcSRPHPRVcBNBkvqCgLCZvL1dkZ1/94UQ9zzz
	2ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=uRP3ezzgFeA6PA9L6hGU+PFYnhIg6psbXQL+LLwSnqQ=;
	b=WsW+tVQgYfvL14H56lHrUBL4qNT4nU06Cc5vj3dldtj4cpAnUXbcvQswfkQzlAr6qJ
	KEJkK2vBau5JNSqO/wxky9nS9imRZgf3MB0xO+rvFVuAYVEjF+FUuCZWs2MW9B2UU0BF
	JvNZYfMWpb4fhmVzBgWODn+yiSNJ2HZdnHr7Pzs+zU5vbgjLVrJkfIU18dqjnpmNZw4X
	2yezdeqb+pxUcgekNxKosW+2ffuSALXdDpzOQc+p1zifJJgkExfKIaNIOYimeMygRpCK
	hQxN3i8rJXxCqzLr+I1rikLQgbkkbW6WOh81kc8pmT3k9REbmGg6/07Iv/JAX6csHLRA
	Pn6w==
X-Gm-Message-State: ALoCoQk8bz5mzt3jT/N3dKlcrgiF7U+yt/lrMOWBqj6Rz7By5BoSUn2Rcez4+SZMP1Ot1F6BjaKsJF4tCvmPiYMVX+knTeKUMhKnk9wJC58GFhAKjeseuYU=
X-Received: by 10.28.57.65 with SMTP id g62mr34927851wma.65.1449703676003;
	Wed, 09 Dec 2015 15:27:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.184.110 with HTTP; Wed, 9 Dec 2015 15:27:36 -0800 (PST)
In-Reply-To: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
References: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 10 Dec 2015 00:27:36 +0100
Message-ID: <CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
To: Andre McCurdy <armccurdy@gmail.com>
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
X-List-Received-Date: Wed, 09 Dec 2015 23:27:59 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 1, 2015 at 6:13 AM, Andre McCurdy <armccurdy@gmail.com> wrote:
> I have two recipes within a single layer:
>
>   stblinux_3.14-1.7.bb
>   stblinux_3.14-1.8.bb
>
> If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
> the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
> selected instead.
>
> Reversing the order of files stored in pkg_pn[pn] seems to help. Is it
> a reasonable solution?


I have a somewhat similar issue..

in oe-core we have GCCVERSION set to 5.%, if I add meta-linaro layer
which has gcc_5.1.bb (while OE has gcc_5.2.bb), I am seeing this:

$ bitbake -e gcc | grep ^PV
PV="5.1.0"

While I would expect 5.2.0 to be picked up.

This patch does not fix this issue, btw.

If I remove gcc_5.1.bb from my layers, then I can see:

$ bitbake -e gcc | grep ^PV
PV="5.2.0"

