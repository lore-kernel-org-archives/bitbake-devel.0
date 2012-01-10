Received: from mail-qw0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RkfpN-0005bj-Dw
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:49:41 +0100
Received: by qabj40 with SMTP id j40so239973qab.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=h8q6zLNvZ4ooiQWscQilofkW0PNKum1dFIpiY2sQC/Y=;
	b=XWFleE9XzG+CvHqwTgSE2wlceDlEzONULfB4l/omuM2YLob4TG9GWy8wmCzHNz3A5Y
	bqqLuDVFlkkxvLKCr46WuI0Drw7UNdp/Z8zscP2hbU7F6KX0InMUFpQd1Bqll8PRcZW9
	/z+PxLLC+UrBpNeRl4Q0lzJ2RPlNpP2tRTf4c=
Received: by 10.224.175.2 with SMTP id v2mr26055136qaz.69.1326217332055; Tue,
	10 Jan 2012 09:42:12 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.187.141 with HTTP; Tue, 10 Jan 2012 09:41:49 -0800 (PST)
In-Reply-To: <20120110174903.AB19510333@opal>
References: <20120110174903.AB19510333@opal>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Jan 2012 10:41:49 -0700
X-Google-Sender-Auth: FUAMQZHIgTnrIZm3trbrUjLMM24
Message-ID: <CABcZANkVEUfLCTUTMrkN8J-VWoDaV=-dh4HRokeD-Qpu6i93cg@mail.gmail.com>
To: git@git.openembedded.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Paul Eggleton : bitbake-layers: close files in apply_append()
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
X-List-Received-Date: Tue, 10 Jan 2012 17:49:41 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 10:49 AM,  <git@git.openembedded.org> wrote:
> Module: bitbake.git
> Branch: master
> Commit: 470a160813ce6cf04f83258d46ded5c2ab8bc520
> URL: =C2=A0 =C2=A0http://git.openembedded.org/?p=3Dbitbake.git&a=3Dcommit=
;h=3D470a160813ce6cf04f83258d46ded5c2ab8bc520
>
> Author: Paul Eggleton <paul.eggleton@linux.intel.com>
> Date: =C2=A0 Sun Jan =C2=A08 12:06:51 2012 +0000
>
> bitbake-layers: close files in apply_append()
>
> It's recommended practice to close files when finished with them and the
> code in this function was not doing this.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Given we require 2.6, fyi, you could use the context manager.
--=20
Christopher Larson


