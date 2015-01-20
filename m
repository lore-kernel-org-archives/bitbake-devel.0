Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 342467229E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jan 2015 08:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0K8u2Oc006337; Tue, 20 Jan 2015 08:56:02 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XjYBScv-3yjU; Tue, 20 Jan 2015 08:56:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0K8tlrB006321
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Jan 2015 08:55:59 GMT
Message-ID: <1421744147.1798.39.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 20 Jan 2015 08:55:47 +0000
In-Reply-To: <54BDBC83.9030007@windriver.com>
References: <1421158296.31262.17.camel@linuxfoundation.org>
	<54BCBBF6.4020904@windriver.com>
	<1421663325.1798.31.camel@linuxfoundation.org>
	<54BDBC83.9030007@windriver.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Add pyinotify to lib/
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
X-List-Received-Date: Tue, 20 Jan 2015 08:56:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-01-20 at 10:25 +0800, Robert Yang wrote:
> Hello RP,
> 
> I've got several errors like the following when the system's load is high,
> not sure whether related to pyinotify.
> 
> for example, when do_configure:
> sh: 0: Cannot fork
> 
> when do_package or others:
> Exception: OSError: [Errno 11] Resource temporarily unavailable

We've seen this on the autobuilders too. I don't think this should be
from the pyinotify changes since the worker process is spawned
separately and shouldn't hold watches. Its more likely with the kernel
changes, we created more contention with the performance improvements
and pushed things "over the edge" to the point where configurations
which used to work, are now too contented.

Can we install monitoring on these systems and figure out which
resources are unavailable?

Cheers,

Richard


