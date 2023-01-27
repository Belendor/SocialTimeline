import React from "react";

const styles = {
  header: {
    background: "#333",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "space-between",
    padding: "1rem",
  },
  title: {
    margin: 0,
  },
  nav: {
    display: "flex",
  },
  navItem: {
    color: "#fff",
    textDecoration: "none",
    marginLeft: "1rem",
  },
};

const Header = () => {
  return (
    <header style={styles.header}>
      <h1 style={styles.title}>Artur Website</h1>
      <nav style={styles.nav}>
        <a href="#home" style={styles.navItem}>
          Home
        </a>
        <a href="#about" style={styles.navItem}>
          About
        </a>
        <a href="#contact" style={styles.navItem}>
          Contact
        </a>
      </nav>
    </header>
  );
};

export default Header;
