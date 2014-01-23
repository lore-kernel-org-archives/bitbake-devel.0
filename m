Return-Path: <vaduva.jan.alexandru@gmail.com>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
	[209.85.160.45])
	by mail.openembedded.org (Postfix) with ESMTP id D1E6A6B05F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jan 2014 12:56:44 +0000 (UTC)
Received: by mail-pb0-f45.google.com with SMTP id un15so1806511pbc.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jan 2014 04:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=O41VDrrVyTgBSBNL1TYPv/jm5Ea4US903pbnjgs9wWE=;
	b=P7BVDQmXFGZuY6VrEyZ0j9lVWUk2IiLBI68X8z1RXKqZxXChjvOpgRetqyedmr9obT
	S1NZaxvyfRJHsV+3v3YFKwH4M/ivG6MngYIXM7OZ5eylNLhlYvfDIog/9j0cDobC12rv
	LTkAk5A6c/x5mgingCKh/0tT6vVg0hkIyDz/BU7P4Ct818HiO6kQFLUDcdS2bEIHU/mv
	moJqotJXxFi0vyd+fKClzsc77X7dvcuGE3/2llQ6yvQlHwnBZOzoToSgxaaHPz+rPMN4
	9RyYC2MoZcvib74psj4EGthU64ieKCGyPhvovifa2zgjIz+Td+y7HapDMMPdMhNe79Th
	bgoQ==
MIME-Version: 1.0
X-Received: by 10.68.159.228 with SMTP id xf4mr2480631pbb.74.1390481805603;
	Thu, 23 Jan 2014 04:56:45 -0800 (PST)
Received: by 10.68.104.133 with HTTP; Thu, 23 Jan 2014 04:56:45 -0800 (PST)
Date: Thu, 23 Jan 2014 14:56:45 +0200
Message-ID: <CABwVrCq3x6zu7Fb1ZQbQWSaiRnn2njFa6b5B7wz9oaWgoKM4gQ@mail.gmail.com>
From: jan alexandru vaduva <vaduva.jan.alexandru@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Bitbake interaction
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
X-List-Received-Date: Thu, 23 Jan 2014 12:56:45 -0000
Content-Type: multipart/alternative; boundary=047d7bd75a7816f9e804f0a2c678

--047d7bd75a7816f9e804f0a2c678
Content-Type: text/plain; charset=ISO-8859-1

I am interested in maybe offer support of multiple bitbake commands in the
same build directory.
Can you please help me with some available documentation when interacting
with bitbake.

As I see it now the only available way of interaction with the bitbake tool
is to use yocto and create a build directory, setup the environment and
call the bitbake tool.
I did not found any documentation on how to regenerate the bitbake
executable or any ways of interacting with it.

The only solution that I found was to take by hand the source code and find
the answers by myself. That is fine, but it takes time. Could you please
help with any documentation that will make my work a little easier?

--047d7bd75a7816f9e804f0a2c678
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">I am interested in maybe offer support of multiple bitbake commands in the same build directory.<br>Can you please help me with some available documentation when interacting with bitbake. <br>
<br>As I see it now the only available way of interaction with the
 bitbake tool is to use yocto and create a build directory, setup the 
environment and call the bitbake tool. <br>I did not found any documentation on how to regenerate the bitbake executable or any ways of interacting with it.<br>
<br>The only solution that I found was to take by hand the source 
code and find the answers by myself. That is fine, but it takes time. 
Could you please help with any documentation that will make my work a 
little easier? </div>

--047d7bd75a7816f9e804f0a2c678--
