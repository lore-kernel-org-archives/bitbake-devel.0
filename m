Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1UA2Te-0002gD-Fl
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 19:09:10 +0100
Received: by mail-vc0-f176.google.com with SMTP id fk10so1845806vcb.21
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 09:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:mime-version:from:date:message-id:subject:to:cc
	:content-type:x-gm-message-state;
	bh=0vSmD/vdbkMeXtGjlKwGIj5W6+b4RgNUXVc/533Jm5I=;
	b=hotRcMdy7VJI5NwMWzVXOMSBGj2ywWCykXNu7UUcqS87tU/SIylDv9Tk7wf2qT0vKh
	OXNYIJmENuC5PQAcpoIVOAqN4iy5c+jcmENAXmXcwJodkCKVjMQFgVtBkZvBVTgzoW90
	NAtLZvfuCwG8qo6hk7PZiGtBb2J5aU/UAJuVjYpGi6zz1wV2GYAfVUdQFMYp+Su+RwCc
	Y3ayyRSFgb+Fh+EBVEU8ZQN077wH19wq7va1b/Q8/kqnPAVuUVl76vJAbyqZ8yZFHx3u
	zCMYpE1AqfnaGW0K7UngbyN0q1jJNfDjx2sQGYj+g3OU857JY0snDRthwmQoXoEAmNcH
	9hIQ==
X-Received: by 10.220.228.74 with SMTP id jd10mr10018148vcb.65.1361814740108; 
	Mon, 25 Feb 2013 09:52:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.58.77.105 with HTTP; Mon, 25 Feb 2013 09:52:00 -0800 (PST)
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 25 Feb 2013 17:52:00 +0000
Message-ID: <CAJTo0Lam4Ca-5n-d4TLZKkj2SuqbGvCH15dSiyspHfGEmf2bAg@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
X-Gm-Message-State: ALoCoQl4oNyzvpVcZKQ7yyXq4F8ut8cCxb01lfOFYXginbz3UQEO8TRmfV7462iWRtclC2DiIbYT
Subject: [PATCH][1.16] build.py: avoid deleting taint files when writing stamps
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
X-List-Received-Date: Mon, 25 Feb 2013 18:09:14 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

Can this be merged into the 1.16 series for Danny?

Cheers,
Ross


