Return-Path: <chmorgan@gmail.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id 4BAB260780
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Jul 2013 16:50:52 +0000 (UTC)
Received: by mail-ie0-f179.google.com with SMTP id c10so12654846ieb.24
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Jul 2013 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=73Odx70xZexNxWQi59gtvUkNkmvTTlZMdstR+/vE0Js=;
	b=l/8ocoUtg0bqcNRMmGUe2roFyysnp+9E5+vqyQNWpttuuvfecyRIYCwh8UVZG0s6uQ
	BIjLBCA7+bY2wVaFgFUSHEwahc28g7NI0qT9tKLo1wwEmz0ABcbIr8pgJyj+kfaZJ0CH
	LQwVnsDy+H1iQLn/Fi8H+dCE4HmM4d0V7K9SpERI9EIPX6PCxpMw+g9UNJGBWE99S9Ej
	hcaNoi5bXQ67yE8wDRQM71fvAH4RyTT58MqvEztGT5wb07alqfCza+WBP9+d3tgU1LJX
	BEvlTyjIaDBphmLTfQnjn39aZIPSFNIP0jL1Qx0pWiwOfktbTqmE++3pGohdxT83cg7D
	JBQQ==
X-Received: by 10.43.143.4 with SMTP id jk4mr8849691icc.81.1373388653104; Tue,
	09 Jul 2013 09:50:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.167.235 with HTTP; Tue, 9 Jul 2013 09:50:33 -0700 (PDT)
From: Chris Morgan <chmorgan@gmail.com>
Date: Tue, 9 Jul 2013 12:50:33 -0400
Message-ID: <CAAPegz1FN26Owh8FRkon6zfngQfSJ0C_KUHr2a=AG4PRa4O=Wg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake hang due to dpkg error
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
X-List-Received-Date: Tue, 09 Jul 2013 16:50:52 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hello.

I'm not sure if this was the right place to report a bitbake bug (or
at least what I believe is a bitbake bug).

Ubuntu 13.04 here. The issue I had was that something had interrupted
dpkg, this left around some kind of a lock. I ran a bitbake command,
in this case:

MACHINE=beagleboard ./oebb.sh bitbake console-image

And it hung, almost no cpu usage on the system.

I ended up aborting the tasks and at some point tried to do a dpkg
command like 'sudo dpkg --remove blah' and got:

E: dpkg was interrupted, you must manually run 'sudo dpkg --configure
-a' to correct the problem.

After running 'sudo dpkg --configure -a' I re-ran the bitbake command
and everything seems happy. It appears that bitbake was issuing an apt
or dpkg command and hitting the same issue I saw with the 'dpkg was
interrupted' error but it isn't handling that appropriately and was
deadlocked.

What I'm not sure of is exactly where the hang was, I don't yet
understand bitbake. Here are the tasks that appeared to have been
locked up:

cmorgan@cmorgan-laptop:~$ ps aux |grep bitbake
cmorgan  19494  0.0  0.0  12532  1664 pts/21   S+   11:32   0:00
/bin/bash ./oebb.sh bitbake console-image
cmorgan  20987  0.0  0.0  12420  1520 pts/21   S+   11:32   0:00
/bin/sh /home/cmorgan/git/angstrom_setup-scripts/sources/openembedded-core/scripts/bitbake
console-image
cmorgan  21009  0.0  2.6 261484 214384 pts/21  S+   11:32   0:02
python /home/cmorgan/git/angstrom_setup-scripts/sources/bitbake/bin/bitbake
console-image
cmorgan  21020  0.0  2.6 337316 212824 pts/21  Sl+  11:32   0:00
python /home/cmorgan/git/angstrom_setup-scripts/sources/bitbake/bin/bitbake
console-image
cmorgan  21023  0.0  2.6 337316 211376 ?       S    11:32   0:00
python /home/cmorgan/git/angstrom_setup-scripts/sources/bitbake/bin/bitbake
console-image
cmorgan  21232  0.0  0.0   9436   952 pts/25   S+   12:37   0:00 grep
--color=auto bitbake

I can provide more information if it would be helpful, and if this
isn't the correct place just let me know and I'd appreciate if you
could point me in the right direction.

Chris

