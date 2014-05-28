Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 206B76FB9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 May 2014 12:09:13 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4SC98kT002065; Wed, 28 May 2014 13:09:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QhcUvuNILMIn; Wed, 28 May 2014 13:09:07 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4SC95BU002032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 28 May 2014 13:09:06 +0100
Message-ID: <1401278937.2607.47.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mahyar Yaghmaee <mahyarelc@gmail.com>
Date: Wed, 28 May 2014 13:08:57 +0100
In-Reply-To: <CAB5p4qNLCwAvpanApx6XJ0BJKHLViggiFLUsgyb96dQ4+mVgHw@mail.gmail.com>
References: <CAB5p4qNLCwAvpanApx6XJ0BJKHLViggiFLUsgyb96dQ4+mVgHw@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: meta-ruby recipe fails
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
X-List-Received-Date: Wed, 28 May 2014 12:09:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-05-22 at 09:31 -0700, Mahyar Yaghmaee wrote:
> When I build ruby recipe with Yocto (located at
> meta-openembedded/meta-ruby/recipes-devtools/ruby/ruby_1.9.3-p429.bb)
> on Master branch, I get the following error:
>
> Generating RDoc documentation
> uh-oh! RDoc had a problem:
>
> Directory .ext/rdoc already exists, but it looks like it isn't an RDoc
> directory.
>
> Because RDoc doesn't want to risk destroying any of your existing
> files,
> you'll need to specify a different output directory name (using the
> --op <dir>
> option)
>
run with --debug for full backtrace
> make: *** [rdoc] Error 1
> ERROR: oe_runmake failed
> WARNING: exit code 1 from a shell command.
>
> Any suggestion on how to solve the problem would be great.

Questions like this should go to the openembedded-devel list since its
related to metadata bitbake is parsing and executing, not bitbake
itself.

Cheers,

Richard


