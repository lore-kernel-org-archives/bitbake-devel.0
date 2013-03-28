Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1ULI5Y-00055r-Jr
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 20:02:16 +0100
Received: by mail-wg0-f54.google.com with SMTP id a12so1879206wgh.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Mar 2013 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=UyHDzEtO20LFEXi/LL39Zhtr6TuWIecKvy53QlVyUqw=;
	b=wsfQBcHlFk0xHtEeod+w0Ypb2xeth0jc/mtahiggbVE4ARyIIgbEKB2xuT7q+JviuL
	SYzuw5QWBSdtlquu1bBhXnBu59pJqZ7xZYvnV5VqIvIF9saZCJ0UjzZBIGYsgl6VYjqr
	fd77R3hhV4kI9tHjBGtjakwNNilijLy6Rdqa279nDKs1rTqQn824PazBAX4yzKgSQipQ
	8g7g2YksEaoPAMXFOvjN3CbCJ75w4rSuVz8X3pB7TxDuIewy1svxaX2ppSQy3sTxs89O
	R9XqvtBsv/V1Hmpmnr+P526qPCsRoURme99Mb1pd3iJt5j5aEtX/httEFzrIXzyoNunw
	zpfQ==
MIME-Version: 1.0
X-Received: by 10.180.85.103 with SMTP id g7mr14022239wiz.23.1364496313806;
	Thu, 28 Mar 2013 11:45:13 -0700 (PDT)
Received: by 10.194.45.100 with HTTP; Thu, 28 Mar 2013 11:45:13 -0700 (PDT)
In-Reply-To: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
Date: Thu, 28 Mar 2013 14:45:13 -0400
Message-ID: <CAHUNapRpG++6MYT0JcD7Y=o3Hj2Q=jaQVRhbUwewhKFDwcECjQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/6] Add file information to package information window
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
X-List-Received-Date: Thu, 28 Mar 2013 19:02:17 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Mar 28, 2013 at 4:23 AM, Andrei Dinu
<andrei.adrianx.dinu@intel.com> wrote:
> Listing the files that are brought into an image
> from each package.

This sounds like a great feature! Is this also available from the
bitbake command-line as well?


