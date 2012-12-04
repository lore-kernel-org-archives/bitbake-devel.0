Received: from heron.softorchestra.com ([63.192.205.162])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aland@SoftOrchestra.com>) id 1Tfhyv-0001ro-6V
	for bitbake-devel@lists.openembedded.org;
	Tue, 04 Dec 2012 03:11:41 +0100
Received: from heron.softorchestra.com (heron.softorchestra.com [192.168.1.50])
	by heron.softorchestra.com (MTX) with ESMTP id 48C882C1582
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Dec 2012 17:30:19 -0800 (PST)
Date: Mon, 3 Dec 2012 17:30:19 -0800 (PST)
From: Alan DuBoff <aland@SoftOrchestra.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <alpine.DEB.2.02.1212031726110.5149@heron.softorchestra.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Subject: libstdc++.so.6 not in target image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 04 Dec 2012 02:11:51 -0000
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

I tried to inclue gcc-runtime in my image recipe, but it complains that it 
can't build the image.

I was wanting to get libstdc++.so.6 in my target image so I don't need to 
build as static.

What is the recommended way to achieve this?

--

Regards,
Alan


