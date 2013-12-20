Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id CA7C760C12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 11:38:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBKBbwKu004362; Fri, 20 Dec 2013 11:37:58 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gHOxJobCvZEO; Fri, 20 Dec 2013 11:37:58 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBKBbrea004359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Dec 2013 11:37:55 GMT
Message-ID: <1387539469.6402.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: David Good <david.good1@gmail.com>
Date: Fri, 20 Dec 2013 11:37:49 +0000
In-Reply-To: <CALMFhSzPCspAJ6BbgD0dYk7EVP780zQPb8enJ7YCYY05mBdf8g@mail.gmail.com>
References: <CALMFhSzPCspAJ6BbgD0dYk7EVP780zQPb8enJ7YCYY05mBdf8g@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Running configure script up one dir
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
X-List-Received-Date: Fri, 20 Dec 2013 11:38:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2013-12-19 at 23:18 -0600, David Good wrote:
> I hope that this is the right list for my question.

Its really a question that should go to the openembedded-core list since
its about the metadata which is part of OE-Core.

>   I'm trying to write a bb recipe for Angstrom v2012_12 (BeagleBone
> Black) for the tDOM package which uses autotools in a strange way (to
> me anyhow).  configure is expected to be run from /(project
> root)/unix, like this:

It tricky to do but the freetype recipe in OE-Core shows one way of
handling this. 

Cheers,

Richard



