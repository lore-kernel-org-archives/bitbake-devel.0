Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S7ks2-0008Tw-Lf for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:51:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2E9h5cv006163;
	Wed, 14 Mar 2012 09:43:05 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02825-09; Wed, 14 Mar 2012 09:43:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2E9gvWC006157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 09:42:58 GMT
Message-ID: <1331718176.18586.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <Kai.Kang@windriver.com>
Date: Wed, 14 Mar 2012 09:42:56 +0000
In-Reply-To: <4F605E85.7070904@windriver.com>
References: <4F605E85.7070904@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: How to identify WORKDIR?
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
X-List-Received-Date: Wed, 14 Mar 2012 09:51:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-14 at 17:01 +0800, Kang Kai wrote:
> Hi All,
> 
> I write a script to clean up WORKDIR that remove the obsoleted
> packages' build directories. 
> The script accept a argument as BUILDDIR and I use this clause to
> identify the WORKDIR:
> 
>      workdir = os.path.join(builddir, 'tmp/work')
> 
> Then validate the workdir exists or not. It works for me but hardcode
> here as Richard point out. 
> So is there  a better way to get the WORKDIR here? Thanks.

I was thinking of something like:

bitbake -e | grep ^WORKDIR

since you already call into bitbake in the script in question.

Cheers,

Richard




