# $NetBSD$

DISTNAME=	watchman-2.9.1
CATEGORIES=	local
MASTER_SITES=	https://github.com/facebook/watchman

PKGNAME= watchman-2.9.1nb2
MAINTAINER=	alciregi@gmail.com
HOMEPAGE=	https://github.com/facebook/watchman
COMMENT=	Watches files and takes action when they change
LICENSE=  apache-2.0

WRKSRC=   ${WRKDIR}/${DISTNAME}

BUILD_DEFS+=         VARBASE

USE_TOOLS+= aclocal autoconf automake autoheader
GNU_CONFIGURE=  yes

MESSAGE_SUBST+= SAMPLEDIR=${SAMPLEDIR} VARBASE=${VARBASE}

CONFIGURE_ARGS+= --prefix=${PREFIX}
CONFIGURE_ARGS+= --enable-conffile=${PKG_SYSCONFDIR}/watchman.json
CONFIGURE_ARGS+= --enable-statedir=${VARBASE}/spool/watchman

OWN_DIRS+=    ${VARBASE}/spool/watchman
SAMPLEDIR=  ${PREFIX}/share/examples/${PKGNAME}

SMF_MANIFEST_SRC= ${FILESDIR}/manifest.xml

MAKE_DIRS_PERMS+=	${VARBASE}/spool/watchman ${ROOT_USER} ${ROOT_GROUP} 0777

CONF_FILES= ${SAMPLEDIR}/watchman.json ${PKG_SYSCONFDIR}/watchman.json

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

CONFIGURE_SCRIPT= ${WRKSRC}/configure

post-install:
	${INSTALL_DATA_DIR} ${DESTDIR}${SAMPLEDIR}
	${INSTALL_DATA} ${FILESDIR}/triggersample.sh ${DESTDIR}${SAMPLEDIR}/triggersample.sh
	${INSTALL_DATA} ${FILESDIR}/watchman.json ${DESTDIR}${SAMPLEDIR}/watchman.json
	${INSTALL_DATA} ${FILESDIR}/root.state ${DESTDIR}${SAMPLEDIR}/root.state

#	${INSTALL_DATA_DIR} ${DESTDIR}${DOCDIR}
#	${INSTALL_DATA} ${WRKSRC}/README.markdown ${DESTDIR}${DOCDIR}/README.markdown

.include "../../mk/bsd.pkg.mk"
