Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1TwGWi-0007qW-My
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 19:18:52 +0100
Received: by mail-wg0-f44.google.com with SMTP id dr12so2381279wgb.35
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2013 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=yKcPalS6oRDH+nHz/p7tTgnnnb2Fn4LzoXe3vnYbdmA=;
	b=HZ1+q9WVPiO/dtSb0K41yJB+VNTePEiLJJ+p5GFo2/KVn78Bh9k1Icjr7fzapNbULu
	F45ilcFArSDTe4QiicIbMibyWrfvX+9T3W43Rc45zejzzZ/pQnF0c0iIDS9w9LE/B29M
	M46zJLIkoF0U8mfpEQ7CstIv59kFhDAeCO+Bcn69acNr0PNkJSPgDZyfuovbwS4tscdi
	fbnvOiJ3o4MLNDXZAAJSalFN9A0NU4uApz2TO4Hkz3i3TJP5cfkBcorClnFgp/Zx7Nxw
	PLoBUV8BwA/+SUWqXlV6LZiLajJQCIe8rc9EjzluhVQRF7gSBlYGdJlQOH+LGF9tNXQ+
	T5VA==
MIME-Version: 1.0
X-Received: by 10.194.172.228 with SMTP id bf4mr15736738wjc.38.1358532205395; 
	Fri, 18 Jan 2013 10:03:25 -0800 (PST)
Received: by 10.227.132.205 with HTTP; Fri, 18 Jan 2013 10:03:25 -0800 (PST)
Date: Fri, 18 Jan 2013 13:03:25 -0500
Message-ID: <CAHUNapQHDYC7g4aJnPH5U784rywtX1AnwVkbY9e1RJrB5mPszg@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: task override
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
X-List-Received-Date: Fri, 18 Jan 2013 18:18:53 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I was just wondering if it is possible to define, in a layer, a task
that will override all other such tasks such that only mine runs?

I would like to perform a regular build:

$ bitbake myimg

and in my layer I would like to have:

-- meta-mylayer
    |-- recipes-core
    |   `-- images
    |       `-- myimg
    |            ...
    |            inherit core-image
    |            inherit myclass
    |            ...
    |
    `-- classes
        `-- myclass
            addtask rootfs
            myclass_do_rootfs() {
                echo "rootfs from myclass!"
            }
            EXPORT_FUNCTIONS do_rootfs

such that when the build is run, all tasks are run, and when it comes
time for the "do_rootfs" task, mine is run (which does nothing,
essentially skipping the whole task) and the build continues.

Maybe I'm hitting a state-cache problem (since I'm doing this one
piece at a time, adding a little bit then running "bitbake myimg"
without doing any cleaning)?

As far as I can tell, my additions make no change to the build.
Everything appears to run as it did before (in other words, I can't
even find my "rootfs from myclass!" string anywhere in the logs).

Best regards,
    Trevor


