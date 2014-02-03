Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-ea0-f180.google.com (mail-ea0-f180.google.com
	[209.85.215.180])
	by mail.openembedded.org (Postfix) with ESMTP id C6BDC6E8B1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 22:26:53 +0000 (UTC)
Received: by mail-ea0-f180.google.com with SMTP id o10so4037979eaj.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Feb 2014 14:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=Ai28Am82xpFqewFKzjl23XfAZ+DmNdCVUfHg6JN8WGc=;
	b=s8ZGOIo/j4eDnrmLBs5Q9Z37azpfMH4AURS7y9JuFGIcNlasccsYXDTLqvle15YUHl
	QHsJ2rABzreraCuFEXjlkJzsEDHrJSxpWpSSe7QsirSQB8QIq3tgoyGkk40yR277JttL
	ULSZpmOmf/uScOCNCLcB7AOTwbb8jhnxNI6NwKVv7z8goTM0dvBb86nhdCbLgyaaPLP2
	8jcwkYycMHz20k6j72m2icNmIR+ZIGxd3EMd7/Bb3Z9m0wqLzk7X7nuXdYVnsUz0pz1k
	u7fPviNZLWcIxsyWJa6rlxX0cWirPL+EpT9oY03qEXONr7A1aGv0lSmNPgYSqMs4Sy3j
	JTaQ==
X-Received: by 10.14.173.68 with SMTP id u44mr5357159eel.102.1391466414062;
	Mon, 03 Feb 2014 14:26:54 -0800 (PST)
Received: from nbbrfq.cc.univie.ac.at
	(91-119-228-86.dynamic.xdsl-line.inode.at. [91.119.228.86])
	by mx.google.com with ESMTPSA id m9sm67028994eeh.3.2014.02.03.14.26.52
	for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Mon, 03 Feb 2014 14:26:53 -0800 (PST)
Date: Mon, 3 Feb 2014 23:26:51 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: jan alexandru vaduva <vaduva.jan.alexandru@gmail.com>
Message-ID: <20140203222651.GB13798@nbbrfq.cc.univie.ac.at>
References: <CABwVrCq3x6zu7Fb1ZQbQWSaiRnn2njFa6b5B7wz9oaWgoKM4gQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABwVrCq3x6zu7Fb1ZQbQWSaiRnn2njFa6b5B7wz9oaWgoKM4gQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake interaction
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
X-List-Received-Date: Mon, 03 Feb 2014 22:26:54 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 02:56:45PM +0200, jan alexandru vaduva wrote:
> I am interested in maybe offer support of multiple bitbake commands in the
> same build directory.
> Can you please help me with some available documentation when interacting
> with bitbake.
> 
> As I see it now the only available way of interaction with the bitbake tool
> is to use yocto and create a build directory, setup the environment and
> call the bitbake tool.
> I did not found any documentation on how to regenerate the bitbake
> executable or any ways of interacting with it.

I fear i cannot really help, but bitbake, being a python script, is
built like any other python project:
$ python ./setup.py build
running build
running build_py
running build_scripts
make: Nothing to be done for `html'.
$ (cd build && ln -s lib.* lib)

This builds bitbake and generates html documentation that i recommend
reading with your favourite browser.
> 
> The only solution that I found was to take by hand the source code and find
> the answers by myself. That is fine, but it takes time. Could you please
> help with any documentation that will make my work a little easier?

It is quite possible that the documentation covers the basic stuff to
start your own bitbake-based project i fyou do not want to use one of
the pre-existing projects using bitbake. I think that getting a basic
system of .bb files going should not be all that hard, fwiw.

HTH,

