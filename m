Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A66866CCC9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 17:57:12 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rA1Hv2jY011253; Fri, 1 Nov 2013 17:57:02 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rg3SeBrhGmwp; Fri,  1 Nov 2013 17:57:02 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rA1HuwTx011237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 1 Nov 2013 17:57:00 GMT
Message-ID: <1383328614.6271.60.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Date: Fri, 01 Nov 2013 17:56:54 +0000
In-Reply-To: <526FE2D3.7020808@digitalendoscopy.de>
References: <526FE2D3.7020808@digitalendoscopy.de>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: HG Fetch with username and password in url
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
X-List-Received-Date: Fri, 01 Nov 2013 17:57:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-10-29 at 17:31 +0100, Volker Vogelhuber wrote:
> We currently use an company internal mercurial server with username
> and 
> password authentication
> that will be accessed during the build of a firmware image from within
> a 
> custom recipe.
> The only way to access it from within the yocto toolchain seems to
> have 
> the username and password
> stored within the URL of the SRC_URI variable.
> 
> But the current hg.py fetcher does not completely support this.
> Attached 
> is a patch that fixes the missing parts.

Thanks. In the future, a commit message and a Signed-off-by line would
help but I've merged this change.

Cheers,

Richard


