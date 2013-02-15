Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U6Nxm-0000Qy-I1 for bitbake-devel@lists.openembedded.org;
	Fri, 15 Feb 2013 17:16:41 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1FG6dcL013102; Fri, 15 Feb 2013 16:06:39 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xXJEImZDe+Qd; Fri, 15 Feb 2013 16:06:39 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1FG6W7S013088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 15 Feb 2013 16:06:35 GMT
Message-ID: <1360944017.31795.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>, Martin Ertsaas <martiert@gmail.com>
Date: Fri, 15 Feb 2013 16:00:17 +0000
In-Reply-To: <CABcZANmd9_bcAUizAR3JiSX368HJsKhzGrGPkqAsbMsw2G9=ig@mail.gmail.com>
References: <1360281302.10722.68.camel@ted>
	<CABcZANmd9_bcAUizAR3JiSX368HJsKhzGrGPkqAsbMsw2G9=ig@mail.gmail.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Use rm -rf in remove()
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
X-List-Received-Date: Fri, 15 Feb 2013 16:16:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-02-07 at 18:08 -0700, Chris Larson wrote:
> 
> On Thu, Feb 7, 2013 at 4:55 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         -                shutil.rmtree(name)
>         +                # shutil.rmtree(name) would be ideal but its
>         too slow
>         +                subprocess.call('rm -rf %s' % path,
>         shell=True)
> 
> This is a good idea, but I'm curious about forking off a shell process
> for it. I'd think this would work as well: subprocess.call(['rm',
> '-rf', path])

path can have wildcards in it. The code wasn't entirely obvious so I've
tweaked it after your/Peter's comments. I'm hoping it will help the
problems Martin was seeing too.

Cheers,

Richard




