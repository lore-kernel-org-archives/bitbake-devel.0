Received: from mail-vc0-f171.google.com ([209.85.220.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <wmat@alphatroop.com>) id 1UUMUN-0002XS-OG
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 21:33:24 +0200
Received: by mail-vc0-f171.google.com with SMTP id ha11so2097211vcb.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Apr 2013 12:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:mime-version:x-originating-ip:from:date:message-id
	:subject:to:content-type:x-gm-message-state;
	bh=P9rlebFQHDxxsFFILXpdruVm7LZu9WVk+uKvVtH8VAI=;
	b=UT880n/Q+xDmCatbAgdn5u0S6cQIMOPZJH4+FDHXZHswBcwnEnGhcS13jN5Q4ft3SA
	eB/F73hHNRGiEUCFcAMxLYQGKN+TmFtmBl8lkECp0T8jRKoRl65JifxAn8Mg7W1Jmt56
	0LkIjJsWQXns++45JpxAWQfPiZfrRylZ11HmS6zC2m2ZGLwpmP0rbA7GV00dvlo/qaf0
	MgbYFeNNUXaenjexQqR4uLc0tv3B8HxZDCFyNbQp0fwvqHIn1WI25/hshlQaBj+CKMw+
	I0yMpC6GVBVVV/13PA0tH1TqGzYzBSxrUmDdbZM56S9MQ8v67iZIraSNC7TIRKNd3hLM
	Qc2g==
X-Received: by 10.58.212.8 with SMTP id ng8mr20091951vec.25.1366658144027;
	Mon, 22 Apr 2013 12:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.58.4 with HTTP; Mon, 22 Apr 2013 12:15:23 -0700 (PDT)
X-Originating-IP: [24.246.30.132]
From: "William M.A. Traynor" <wmat@alphatroop.com>
Date: Mon, 22 Apr 2013 15:15:23 -0400
Message-ID: <CAGfZjq6Ldap337bm21g286gkjgtBS45ti68JwrAtWb1t+fKZEw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQlF2DAAU3Rij29qIRraAP+QOHAkCM/Jms8WQXaeDctX0bvqWgTuDZKfVQLlN3RqE9RoiK9E
Subject: Accessing Variables and the Data Store from Python
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
X-List-Received-Date: Mon, 22 Apr 2013 19:33:29 -0000
Content-Type: text/plain; charset=ISO-8859-1

Hey there,

I'm expanding the documentation in the BitBake manual regarding
accessing variables and the data store from Python.  Is there a
particular source tree where I can see good examples of this
occurring?

I grepped the OE repo for methods such as "d.apendVarFlag" and
"d.prependVarFlag" but did not find any instances.  I'm grepping the
Poky repo now.

Thanks
Bill


