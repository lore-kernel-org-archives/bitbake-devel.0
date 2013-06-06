Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AE7526A456
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jun 2013 08:13:41 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r568IWJh015402; Thu, 6 Jun 2013 09:18:32 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wR0MrvwUmJd2; Thu,  6 Jun 2013 09:18:32 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r568ISRY015389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 6 Jun 2013 09:18:29 +0100
Message-ID: <1370506401.1640.71.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Ming Chan (chanm)" <chanm@cisco.com>
Date: Thu, 06 Jun 2013 09:13:21 +0100
In-Reply-To: <A8108027F6475848B4BB89A74BA7AE4319386579@xmb-rcd-x07.cisco.com>
References: <A8108027F6475848B4BB89A74BA7AE4319386579@xmb-rcd-x07.cisco.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Question on including ruby 1.9.3 in embedded image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Jun 2013 08:13:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-06-05 at 18:46 +0000, Ming Chan (chanm) wrote:
> We are trying to include ruby-1.9.3 by using the recipe in
> the meta-openembedded/meta-ruby(git://git.openembedded.org/meta-openembedded), Issues seen during the bitbake run:
>      1. While package ruby-native-1.9.3-p194-r1.0, task do_compile
>         failed with "undefined symbol: rb_encdb_declare", the work
>         around this issue is to use --disable-rdoc 
>      2. While package ruby-1.9.3-p194-r1.0, task do_compile failed
>         with the following: 
>                 template/Doxyfile.tmpl:22: uninitialized constant
>                 RUBY_REVISION (NameError).  The work around is to use
>                 0 instead of RUBY_REVISION.
>               * executable host ruby is required.  The work around is
>                 to use --with-baseruby option and provide baseruby
>                 from build machine.
>               * ext/etc/extconf.rb:8: undefined method `escape' for
>                 Shellwords.  This issue is caused by the version of
>                 executable host ruby is to old.  This issue
>                 disappeared after using ruby-1.8.7 on the build
>                 machine.
>               * The current issue is "../.././lib/erb.rb:586:in
>                 `compile': undefined method `encoding' for 
>                 #<String:0x2a9560fee0> (NoMethodError)"
> Does it make sense for the work around described?  Any requirement
> (i.e. The version of gcc) is needed to use  the recipe in
> the meta-openembedded/meta-ruby? 
> 
This mailing list is about bitbake itself, not about metadata and build
problems. See the README in the meta-opembedded layer for details on
where to take questions (its the openenembedded-devel mailing list in
this case).

FWIW it is a bug that you have to work around these issues however the
quality of recipes in meta-openembedded is variable.

Cheers,

Richard




