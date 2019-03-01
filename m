Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id 5EFE57CD75;
	Fri,  1 Mar 2019 11:28:27 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id d24so19792256ljc.12;
	Fri, 01 Mar 2019 03:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=bINtz8B3hTHGRyIFAYJeQ62uRhP4nu4XVaCG9F5KXvE=;
	b=oVga1XW8esVXipz09EqHEted7/1eG/QI13n4aXC614DLCozfnIw/31TcoldgBasNpB
	wD2U6sl3xZYB1PHKjitjccq2UinP60xFJSalOx8R6nYwcRdeDMjLKOejy0sqtDb0/HDj
	Zi7PmCUSCgEwiQUoslxozb1lcF4N4cIV0GH6a3ieyo+zNeQ/sPtoYXRXwB6p88SErLGt
	ckoFi/fhDLfRhzaoo2gkFveL1HBYSgfDq2gY70gSOCV3vfhKUWq/uwKQoSb4DWZ0RY79
	kahrpR4ixFfLH5DEiNwc7SF6LmAIHpgUD3aldGdWRiR19Uw/oFPs20n7ny579AlwM5oP
	hXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=bINtz8B3hTHGRyIFAYJeQ62uRhP4nu4XVaCG9F5KXvE=;
	b=KH518/qrXrS6/5/DKIPdfi+6plHV6Yb0SKSWKi3xZ3tjhKH4iWaGrHT08HmIkkf4u/
	bVxRF7xZqjB9vTxtERMrTZrDCLpy+seCaaQakUEkiVraMjdApOt2G9AM3+C4bRnTst5F
	C2ag+Kp0TL4an6TTen1o03noyzET7G1QL21g6iWnmpT7EbWXvedIhxQv9sba2vlHVuGJ
	u/YE/csMKmO5hKbEnTLqQVUYBDBwvUhx4yarhwhPLy9f4O9Tr8e+Mr2JBOCE326iD1pJ
	l/Keh+nEne7UxMGuju9TCIR1mpL2XYyltbwZElKNAFYuw3XWms0K4aHilECFImG2ZCyn
	dp1A==
X-Gm-Message-State: APjAAAWEZFLM7vFsdjlYa9VtApWvZvoXCL1lpkJTpwYmz3CW6Rmo8zcl
	pATNTkwaMw2wnAewsaPrFXNDofcqicwIOIqXyn1VexlW
X-Google-Smtp-Source: APXvYqye47/YKo68znnxZcTBATFwB9UrXVPWAz63l4BC9HKFu8rpk2OyKT7bxMxWp4Dv85Ln4qInFSSPn5ooHgUe6QA=
X-Received: by 2002:a2e:84ca:: with SMTP id
	q10-v6mr2404958ljh.65.1551439707364; 
	Fri, 01 Mar 2019 03:28:27 -0800 (PST)
MIME-Version: 1.0
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 1 Mar 2019 12:28:11 +0100
Message-ID: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
To: openembedded-core <openembedded-core@lists.openembedded.org>, 
	Daniel Gomez <daniel@qtec.com>, bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Sat, 02 Mar 2019 23:04:22 +0000
Subject: Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Fri, 01 Mar 2019 11:28:27 -0000
Content-Type: text/plain; charset="UTF-8"

Hello

I have a build system that supports some aarch64 machines. For most of
the them, the only difference is the kernel configuration, kernel
version.

I am using multiconfig on my build server and the build goes really
fast thanks to all the shared binaries/artifacts.

But I have a problem adding a new machine. This machine is also
aarch64, with a special kernel (nothing new here), but in this case
the vendor provides a binary .so for libgl that is required to get
hardware acceleation.

I could .bbappend mesa and on the installation part replace libgl with
the new .so. But then everything that depends on mesa needs to be
rebuilt for that machine and I could not use multiconfig.

Instead I have created a new recipe: mesa-gl-replace.bb that has the
file. This breakes completely the design of OE, but works.

Some snipsets of the "magic" to make it work:

#Force that the version is allways higher than the one from mesa:
PE = "5"

#Rprovide the same as mesa
RPROVIDES_libgl-mesa += "libgl"

#Do not overwrite pkgdata of mesa
PACKAGEFUNCS_append = " rm_pkgdata_runtime"
rm_pkgdata_runtime() {
rm -rf ${WORKDIR}/pkgdata/runtime/*
rm -rf ${WORKDIR}/pkgdata/shlibs2/*
}

#Keep this on machine
PACKAGE_ARCH = "${MACHINE_ARCH}"

#Make sure we are not saved as providers for libgl
PRIVATE_LIBS = "libGL.so.1"

#Avoid sanity checks
read_subpackage_metadata () {
}


If your eyes have not fallen as this point, this means you have a lot
of tolerance for crappy code, congrats :)

Now the question. Is there a better way to do this?

PS: I already tried and failed with update_alternatives


Best regards!


-- 
Ricardo Ribalda

