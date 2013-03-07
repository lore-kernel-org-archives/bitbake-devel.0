Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UDYed-0005Sq-R2 for bitbake-devel@lists.openembedded.org;
	Thu, 07 Mar 2013 12:06:33 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r27Aw0Sh009292; Thu, 7 Mar 2013 10:58:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13cMj93kuHLN; Thu,  7 Mar 2013 10:57:59 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r27Avs6Q009287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 7 Mar 2013 10:57:57 GMT
Message-ID: <1362653385.9443.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 07 Mar 2013 10:49:45 +0000
In-Reply-To: <20130304182459.GJ3268@jama>
References: <1362243005-12124-1-git-send-email-Martin.Jansa@gmail.com>
	<5134C272.7090008@windriver.com> <20130304182459.GJ3268@jama>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen: add quotes around variable values to see whitespace
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
X-List-Received-Date: Thu, 07 Mar 2013 11:06:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-03-04 at 19:24 +0100, Martin Jansa wrote:
> On Mon, Mar 04, 2013 at 09:49:06AM -0600, Mark Hatle wrote:
> > On 3/2/13 10:50 AM, Martin Jansa wrote:
> > > * without this change it's hard to see what's changed:
> > >    bitbake-diffsigs sstate-cache/*/sstate-depmodwrapper-cross-cortexa8-vfp-neon-oe-linux-gnueabi-1.0-r0-cortexa8-vfp-neon-*_populate-sysroot.tgz.siginfo
> > >    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
> > >    Variable TUNE_CCARGS value changed from  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8  to  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8
> > >    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3
> > >
> > > * with this change, we can see extra trailing space in first version:
> > >    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
> > >    Variable TUNE_CCARGS value changed from ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 ' to ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8'
> > >    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3
> > 
> > No objection to this patch, but it does raise the question.  Should we somehow 
> > strip the leading and training white space, maybe even multiple spaces (like 
> > above) and then use the results to generate the checksum?
> > 
> > If I saw the above, my first comment would be "well that's stupid, the output is 
> > the same"..  (Of course performance might be impacted by all of that stripping..)
> 
> I had the same comment when I've seen it, that's why I added those
> quotes to be able to spot that space at all.
> 
> I'm not sure what caused that extra space and so many rebuilds, but I've
> noticed it today in completely different build where space in multiline
> variable were squashed to one space separator and I think the only
> difference were pool patches in bitbake.

The pool patches shouldn't make any difference to this so this is rather
bizarre. Do you have anything you can reproduce at will (ignoring the
pool patches since they've been reverted for other reasons now).

Cheers,

Richard



