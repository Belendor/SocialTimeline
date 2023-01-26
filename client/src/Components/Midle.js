import React, { useState } from 'react';

const Midle = () => {
  const [isVisible, setIsVisible] = useState(false);

  return (
    <section style={styles.container}>
      <h2 style={styles.title}>Welcome to my website</h2>
      <button style={styles.button} onClick={() => setIsVisible(!isVisible)}>
        Show/Hide Text
      </button>
      <p style={{ ...styles.text, ...(isVisible ? styles.textVisible : styles.textHidden) }}>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam sit amet
        bibendum congue, ipsum magna aliquet augue, at aliquet est augue non risus.
      </p>
    </section>
  );
};

const styles = {
  container: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    padding: '2rem'
  },
  title: {
    textAlign: 'center'
  },
  button: {
    background: '#333',
    color: '#fff',
    padding: '0.5rem 1rem',
    border: 'none',
    cursor: 'pointer',
    marginBottom: '1rem'
  },
  text: {
    transition: 'all 0.5s ease-in-out'
  },
  textVisible: {
    opacity: 1,
    transform: 'translateY(0)'
  },
  textHidden: {
    opacity: 0,
    transform: 'translateY(-1rem)'
  }
};

export default Midle;
