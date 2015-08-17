Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E051665CBC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 07:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7iBId023753; Mon, 17 Aug 2015 08:44:11 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7F_g7e6-lRfO; Mon, 17 Aug 2015 08:44:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7hwnX023749
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2015 08:44:09 +0100
Message-ID: <1439797438.1218.35.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?R=E9mi?= Peuvergne <remi.peuvergne@openwide.fr>
Date: Mon, 17 Aug 2015 08:43:58 +0100
In-Reply-To: <2007448077.5597509.1439371435023.JavaMail.root@openwide.fr>
References: <2007448077.5597509.1439371435023.JavaMail.root@openwide.fr>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Question about python interpreter in methods embedded in recipes
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
X-List-Received-Date: Mon, 17 Aug 2015 07:44:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2015-08-12 at 11:23 +0200, Rémi Peuvergne wrote:
> I've been investigating on an issue when building an image, and I gave
> up doing what I first wanted.
> I'd like to know more about the issue, and possibly suggest an
> improvement to bitbake...
>
> The issue is related to "embedded python methods" in recipes.
>
> In my image recipe, I'm modifying the rootfs (basically to add a
> hashed password to /etc/shadow), with something like :
>
> python set_password() {
> <some piece of python script here>
> }
>
> The thing is, this piece of code is executed by the *host*
> interpreter, so it depends on the dev machine (in my case I ran into
> an issue with crypt.mksalt() not being available).
> It would be nice to allow executing this with the *native*
> interpreter, the one built during the whole image build process.
>
> I tried inheriting pythonnative, which sets the PYTHON variable the
> correct way, but it's not used for those methods...
> I guess it's not easy, since it would need to pass the datastore, but
> I wonder if there's any smart solution to this ?

The system is only setup such that we run the host interpreter. We don't
know when the native python version would become available (or even if
it would get built) and even if we did, we'd then have to switch
interpreters half way through execution.

Such an approach would add a lot of complexity for not a lot of gain. If
you really need pythonnative, you could execute a separate script using
it?

Cheers,

Richard


