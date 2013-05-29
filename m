Return-Path: <wmat@alphatroop.com>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id 5CED260959
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 17:28:31 +0000 (UTC)
Received: by mail-ie0-f175.google.com with SMTP id tp5so8877106ieb.20
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 10:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:from:date:message-id:subject:to
	:content-type:x-gm-message-state;
	bh=UNXlQ5U/RFDLYrepRa4cEfIGxUC7QvuHYmeEwdlliME=;
	b=EOcDM48Qa+veOFQsATh6Y06B5UPAoOJcaE2wnJCJsZ864P7RiRzD8EFLWtyPSakMJ8
	OVJQqycybkimowj/myfe8tM9JJWjY4VXcKHtjhOr4BOq86ZTMt9VjgFNuAkrJ9qgP4Wc
	Vc22iX3JJNK33M5CH6OzTFy2eLAdvH44EgiDB6KHS9xx2c2p+yUEN+YnZ0I0QyZiDaIN
	WAKjMXSxwPdP2z57aa3X1dfo9X01CV8wCSkgUmb0wGQYFcg9kQra/jgJwVtba7GuEYSN
	CGfNlDYVaoy89N7HJzXV5liwrNcpXASVn7Z1AR2C1d4LTwMLjDYezntP/+qdeMDw80HX
	uKPQ==
X-Received: by 10.50.20.130 with SMTP id n2mr10139607ige.87.1369848511782;
	Wed, 29 May 2013 10:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.44.42 with HTTP; Wed, 29 May 2013 10:28:11 -0700 (PDT)
X-Originating-IP: [24.246.30.132]
From: "William M.A. Traynor" <wmat@alphatroop.com>
Date: Wed, 29 May 2013 13:28:11 -0400
Message-ID: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQn2Qi8EBJ80kUmK5IQIMVXG5QJu87mVJ3RltWWK8+c2+eVCWzvZD67zcaldjyl28LSG58GG
Subject: Hello World example for BitBake Manual
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
X-List-Received-Date: Wed, 29 May 2013 17:28:32 -0000
Content-Type: text/plain; charset=ISO-8859-1

In researching and trying to work through a Hello World example for
inclusion in the BitBake Manual, I've been able to reproduce the
examples described in the following thread:
http://www.mail-archive.com/yocto@yoctoproject.org/msg09347.html

and in the following blog post:
http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/

Does anyone have sufficient knowledge of each of these examples to
comment whether they're "generic" enough for the manual?  I'm trying
my best to keep content as generic as possible, but it's proving to be
a struggle at times.

Specifically, I'm finding that it's possible to be to generic, and
thereby not adequately demonstrate the power of the tool.

Thanks
Bill

