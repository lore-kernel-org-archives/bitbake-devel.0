Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1F6746067D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 15:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1IFNKnA016224; Thu, 18 Feb 2016 15:23:20 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J3GCYX7basYM; Thu, 18 Feb 2016 15:23:20 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1IFNHVD016220
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Feb 2016 15:23:18 GMT
Message-ID: <1455808996.28376.89.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>, Ismo Puustinen
	<ismo.puustinen@intel.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 15:23:16 +0000
In-Reply-To: <CABcZANnMqu-Q-ZYUa34ovJZeJ4pWr5NOeTh_e-_0HUZG1MeEdw@mail.gmail.com>
References: <1455795267-8780-1-git-send-email-ismo.puustinen@intel.com>
	<CABcZANnMqu-Q-ZYUa34ovJZeJ4pWr5NOeTh_e-_0HUZG1MeEdw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] Do not suggest PREFERRED_PROVIDER for runtime providers.
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
X-List-Received-Date: Thu, 18 Feb 2016 15:23:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-02-18 at 15:15 +0000, Christopher Larson wrote:
> On Thu, Feb 18, 2016 at 4:34 AM Ismo Puustinen <
> ismo.puustinen@intel.com> wrote:
> > PREFERRED_PROVIDER affects only build-time dependencies. Do not
> > suggest
> > the user to set it if the multiple providers are for runtime
> > packages.
> > 
> > Signed-off-by: Ismo Puustinen <ismo.puustinen@intel.com>
> This is incorrect. Build provider preferences affect runtime provider
> resolution. It'd be better if we used a separate variable for it, but
> that's not the case now.

I think you're both right.

The message as it stands today confuses users no end and we do need to
do something about that. Equally I'm not sure no message at all is an
improvement...

There definitely is a usability problem there.

Cheers,

Richard

